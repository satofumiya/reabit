require 'rails_helper'

RSpec.describe "Booklists", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/booklists"
      expect(response).to have_http_status(:success)
    end
  end
end
