# encoding: utf-8
require 'spec_helper'

describe "Static pages:" do
  #var which is automaticly pasted before .should
  subject { page }
  
  describe "Home page" do
    before { visit root_path}

    it { should have_selector("h1", text: "AllWatch") }
  end

  describe "About page" do
    before {visit blog_about_path}
    
    it { should have_selector('h1', text: 'Co to?') }
  end

end
