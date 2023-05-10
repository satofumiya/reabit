require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/pages/#{@user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
