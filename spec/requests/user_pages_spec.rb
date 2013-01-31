require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "Signup Page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Rejestracja')}
  end
end
