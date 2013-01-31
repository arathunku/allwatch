# encoding: utf-8
require 'spec_helper'

describe "Static pages" do
  #var which is automaticly pasted before .should
  subject { page }
  #varible to use later #{}
  let(:base_title) { 'AllWatch' }
  describe "Home page" do
    before {visit root_path}
    it "should have the title 'Strona Główna'" do
      should have_selector('title', 'Strona Główna | #{:base_title}')
    end

    it "should not have a custom page title" do
      should_not have_selector('title', text: '#{base_title}')
    end
  end

  describe "About page" do
    before {visit '/blog/about'}
    it "should have the title 'Co to?'" do
      visit '/blog/about'
      should have_selector('title', 'Co to? | #{:base_title}')
    end
  end

end