class AllegroAPI
  require "savon"
  HTTPI.adapter = :httpclient
  attr_reader :client, :info

  def initialize(info)
    info[:login_type] ||= 0
    @login_type = info[:login_type]
    @info = AllegroInfo.new(info)
    @client = Savon.client(wsdl: "https://webapi.allegro.pl/uploader.php?wsdl", log: false)
    #Later check in docs if test version can update same as normal 
    #version or I've to check env
    @session = session
  end

  #searching for product based on string
  #Todo:
  # => *refactor that the call is made in outside function and check exceptions(done?)
  def do_search(search_hash)
    raise ArgumentError, "Search-string not specified" if search_hash["search-string"].nil?
    if (search_hash["search-limit"].nil?) || (search_hash["search-limit"] > 100) || (search_hash["search-limit"] < 0)
      search_hash["search-limit"] = 100
    end
    if limit?
      message = Hash.new
      message["session-handle"] = @session
      message["search-query"] = search_hash
      begin
        response = @client.call(:do_search, message: message)
      rescue Savon::SOAPFault => error
        fault_code = error.to_hash[:fault][:faultcode]
        raise ArgumentError, "Invalid password #{fault_code}" if fault_code == "ERR_USER_PASSWD"
        if fault_code == "ERR_NO_SESSION" || fault_code == "ERR_SESSION_EXPIRED"
          session
          retry
        else 
          f = File.new("out.txt", "w")
          f.write(error.to_hash)  
          f.close
          f = File.new("response.txt", "w")
          f.write(response)  
          f.close
          raise "Check out.txt and response.txt for error/response"
        end
      end
    else
      #to-do: push to que or maybe return ERROR CODE 
      #Error with that method, exception?
      raise CustomError, "You exceed API limit"
    end
    response.body[:do_search_response]
  end

  #----------------------------------
  private
  #----------------------------------
  def limit?
    #To-do:
    # => *refactor to use only 1 array of requests?
    # => *calculate the time in seconds that a called need to wait.
    limit_per_second = 60-5 # API limit for requests per second. -x for curiosity 
    limit_per_time = 2100-100 # API limit for requests per time limit - 2100 requests/last 5 minutes
    limit_time = 5*60 #time frame of 5 minutes to m
    time = Time.now

    @requests_second ||= Array.new #Array to hold time frames of requests in last second, cant excced limited_per_second
    @total_limit ||= Array.new #Array to hold time frames of requests in last 5 minutes

    @total_limit.keep_if { |t| time - t < limit_time} #Clean Array of requsts which were made more than 5 mins ago
    @requests_second.keep_if { |t| time - t < 1} #Clean Array of requsts which were made more than 1 second

    if @total_limit.length > limit_per_time
      return nil
    end
    if @requests_second.length > limit_per_second
      return nil
    end
    @total_limit << time
    @requests_second << time
    true
  end

  def update_version
    #update version key if outdated
    puts "Geting valid version key"
    response = @client.call(:do_query_sys_status,
                            message: {"sysvar" => 1, 
                                      "country-id" => @info.country, 
                                      "webapi-key" => @info.key} )
    response.body[:do_query_sys_status_response][:ver_key]
  end

  def session
    @info.ver ||= update_version
    begin
      puts "Calling doLogin"
      if @login_type == 0
        puts "Plain text login"
        response = @client.call(:do_login, message: {"user-login" => @info.login,
                                                "user-password" => @info.password,
                                                "country-code" => @info.country,
                                                "webapi-key" => @info.key,
                                                "local-version" => @info.ver
                                                })
      else
        puts "Login encoded"
        response = @client.call(:do_login_enc, message: {"user-login" => @info.login,
                                        "user-password" => @info.password,
                                        "country-code" => @info.country,
                                        "webapi-key" => @info.key,
                                        "local-version" => @info.ver
                                        })
      end
      response.body[:do_login_response][:session_handle_part]
    rescue Savon::SOAPFault => error
      fault_code = error.to_hash[:fault][:faultcode]
      if fault_code == "ERR_INVALID_VERSION_CAT_SELL_FIELDS"
        @info.ver = update_version
        retry
      elsif fault_code == "ERR_CAPTCHA_REQUIRED"
          puts error.to_hash[:fault].to_s
          raise CustomError, "Fill Captcha"
      elsif fault_code == "ERR_USER_PASSWD"
          puts error.to_hash[:fault].to_s
          raise CustomError, "Wrong Password"
      else 
        puts error.to_hash[:fault].to_s
      end
    end
  end
end

class AllegroInfo
  require "base64"
  require "digest"

  attr_reader :password, :login
  attr_accessor :key, :country, :ver 

  def initialize(info)
    @login = info[:login]
    if info[:login_type] == 0
      @password = info[:password]
    elsif info[:login_type] == 1
      @password = get_password_senc(info[:password])
    else
      @password = get_password_nenc(info[:password])
    end
    @key = info[:webapikey]
    info[:country].nil? ? @country = 1 : @country = info[:country]
    @ver = nil
  end
  #normal encdoing
  def get_password_nenc(pass)
    puts "normal"
    Base64.encode64(Digest::SHA256.new.digest(pass))
  end
  #strict encoding
  def get_password_senc(pass)
    puts "strict"
    Base64.strict_encode64(Digest::SHA256.new.digest(pass))
  end
end

class CustomError < StandardError
  def initialize(oper="CustomError triggered")
    super(oper)
  end
end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
