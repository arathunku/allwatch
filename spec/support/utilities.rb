# encoding: utf-8

def full_title(page_title)
  base_title = "PMON"
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end

def sign_in(user)
  post sessions_path, :session => { email: user.email,   
                                 password: user.password }
end