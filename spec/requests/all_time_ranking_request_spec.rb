require 'rails_helper'

RSpec.describe "AllTimeRankings", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/all_time_ranking/index"
      expect(response).to have_http_status(:success)
    end
  end

end
