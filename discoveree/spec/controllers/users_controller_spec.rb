require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "POST #create" do
    context "with valid attributes" do
        let(:user) { User.new(email: "test@test.com", password: "test", password_confirmation: "test")}
      it "saves a user with valid attributes" do
        expect {
          post :create, :user => @user
        }.to change(User, :count).by(1)
      end
    end
  end

  describe "Get #show User page" do

    let(:user) { FactoryGirl.create :user}
    it "hitting one's own username takes them to profile page" do
      pending "Not sure if I even need to test this"
      get :show
      expect(response).to render_template(user_path(@user.id))
    end
  end
end
