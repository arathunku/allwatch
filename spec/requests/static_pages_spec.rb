# encoding: utf-8
require 'spec_helper'

describe "Static pages" do
  #var which is automaticly pasted before .should
  subject { page }
  #varible to use later #{}
  let(:base_title) { 'AllWatch' }
  describe "Home page" do
    before {visit root_path}

    it { should have_selector('title', 'Strona Główna | #{:base_title}') }
    it { should_not have_selector('title', text: '#{base_title}') }
  end

  describe "About page" do
    before {visit '/blog/about'}
    
    it { should have_selector('title', 'Co to? | #{:base_title}') }
  end

end