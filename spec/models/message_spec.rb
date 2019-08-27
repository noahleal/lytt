require 'rails_helper'

RSpec.describe Api::V1::MessagesController do
  let(:json_response) { JSON.parse(response.body) }
  let(:english_text) { 'I’ll work my way from irony to sincerity in the sinking city, a would be Whitman of the vulnerable grid.' }
  let(:german_text) {
                      'und bräche nicht aus allen seinen Rändern
                      aus wie ein Stern: denn da ist keine Stelle,
                      die dich nicht sieht. Du mußt dein Leben ändern'
                    }
  let(:spanish_text) {
                      'Verde que te quiero verde.
                       Verde viento. Verdes ramas.
                       El barco sobre la mar
                       y el caballo en la montaña.
                       Con la sombra en la cintura
                       ella sueña en su baranda,
                       verde carne, pelo verde,
                       con ojos de fría plata.'
                     }

  describe "Create new english message with new session", type: :request do

    before do
      post '/api/v1/sessions/123456/messages', params: { text: 'I’ll work my way from irony to sincerity in the sinking city, a would be Whitman of the vulnerable grid.' }
    end


    it "returns created status" do
      expect(response.status).to eq (201)
    end

    it "returns the expected attributes in the JSON body" do
      expect(json_response.keys).to match_array(["identifier", "detected_language", "created_at"])
    end

    it "identifies the language as English" do
      expect(json_response["detected_language"]).to eq ("en")
    end
  end

  describe "Create new German message with new session", type: :request do
    before do
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
    end

    it "returns created status" do
      expect(response.status).to eq (201)
    end

    it "returns the expected attributes in the JSON body" do
      expect(json_response.keys).to match_array(["identifier", "detected_language", "created_at"])
    end

    it "identifies the language as German" do
      expect(json_response["detected_language"]).to eq ("de")
    end
  end

  describe "Create new Spanish message with new session", type: :request do

    before do
      post '/api/v1/sessions/123456/messages', params: { text: spanish_text }
    end

    it "returns created status" do
      expect(response.status).to eq (201)
    end

    it "returns the expected attributes in the JSON body" do
      expect(json_response.keys).to match_array(["identifier", "detected_language", "created_at"])
    end

    it "identifies the language as Spanish" do
      expect(json_response["detected_language"]).to eq ("es")
    end

  end

  describe "Does not create a new message if the language is unsupported", :type => :request do

    before do
      post '/api/v1/sessions/123456/messages', params: { text: "Rappelez-vous l'objet que nous vîmes, mon âme,
                                                                Ce beau matin d'été si doux:
                                                                Au détour d'un sentier une charogne infâme
                                                                Sur un lit semé de cailloux,"
                                                        }
    end

    it "returns the proper error" do
      expect(response.status).to eq (422)
    end

  end

  describe "creates English reply", :type => :request do


    it "Creates english reply to two English messages" do
      post '/api/v1/sessions/123456/messages', params: { text: english_text }
      post '/api/v1/sessions/123456/messages', params: { text: english_text }
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "en"
    end

    it "Creates english reply after the first non-english message" do
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
      post '/api/v1/sessions/123456/messages', params: { text: english_text }
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "en"
    end
  end

  describe "Creates Spanish repy", :type => :request do

    it "Creates German reply to two Spanish messages" do
      post '/api/v1/sessions/123456/messages', params: { text: spanish_text }
      post '/api/v1/sessions/123456/messages', params: { text: spanish_text }
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "es"
    end

    it "Creates Spanish reply after the first non-Spanish message" do
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
      post '/api/v1/sessions/123456/messages', params: { text: spanish_text}
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "es"
    end
  end

  describe "Creates German reply", :type => :request do

    it "Creates German reply to two German messages" do
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "de"
    end

    it "Creates German reply after the first non-German message" do
      post '/api/v1/sessions/123456/messages', params: { text: spanish_text}
      post '/api/v1/sessions/123456/messages', params: { text: german_text }
      get '/api/v1/sessions/123456/replies'
      expect(json_response[1]["language"]).to eq "de"
    end

  end



end
