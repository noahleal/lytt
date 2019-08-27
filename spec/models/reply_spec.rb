require 'rails_helper'

RSpec.describe Api::V1::RepliesController do
  let(:json_response) {JSON.parse(response.body)}

  describe "Show list of replies for given session", :type => :request do
    before do
      post '/api/v1/sessions/123456/messages', params: { :text => 'I’ll work my way from irony to sincerity in the sinking city, a would be Whitman of the vulnerable grid.' }
      get '/api/v1/sessions/123456/replies'
    end

    it "returns a status 200 if the session exists" do
      expect(response.status).to eq (200)
    end

    it "returns status 404 if the session doesn't exist" do
      get '/api/v1/sessions/000/replies'
      expect(response.status).to eq (404)
    end

    it "returns appropriate replies" do
      expect(json_response[0].keys).to match_array(["message", "shortname", "reply_to", "created_at", "language"])
    end



  end


end


