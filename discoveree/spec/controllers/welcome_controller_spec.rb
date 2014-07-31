require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do

  describe "get started >>" do
  let(:user) { FactoryGirl.create(:user)}
  subject { page }
      visit users_login_path
    it "renders a login form" do
      expect(:response).to redirect_to(users_login_path)
    end
  end

end
    # xit "when user is in a session, it redirects them to user_categories_path" do
    #   get :root
    #   expect(response).to redirect_to 'user_categories_path(user)'
    # end

