require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /new" do
    before do
      @user = FactoryBot.create(:user)
      @book = FactoryBot.create(:book, user: @user)
      sign_in @user
    end

    it "returns http success" do
      get "/posts/new?book_id=#{@book.id}"
      expect(response).to have_http_status(:success)
    end
  end

end
