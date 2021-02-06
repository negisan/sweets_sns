require 'rails_helper'

RSpec.describe "WeeklyRankings", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/weekly_ranking"
      expect(response).to have_http_status(:success)
    end
  end

end
