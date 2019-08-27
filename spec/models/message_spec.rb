require 'rails_helper'

RSpec.describe Api::V1::MessagesController do
  let(:json_response) {JSON.parse(response.body)}

  describe "Create new english message with new session", :type => :request do

    before do
      post '/api/v1/sessions/123456/messages', params: { :text => 'I’ll work my way from irony to sincerity in the sinking city, a would be Whitman of the vulnerable grid.' }
    end


    it "return created status" do
      expect(response.status).to eq (201)
    end

    it "returns the expected attributes in the JSON body" do
      expect(json_response.keys).to match_array(["identifier", "detected_language", "created_at"])
    end

    it "identifies the language as English" do
      expect(json_response["detected_language"]).to eq ("en")
    end
  end

  describe "Create new German message with new session", :type => :request do
    before do
      post '/api/v1/sessions/123456/messages', params: { :text => 'und bräche nicht aus allen seinen Rändern
                                                                   aus wie ein Stern: denn da ist keine Stelle,
                                                                   die dich nicht sieht. Du mußt dein Leben ändern' }
    end

    it "return created status" do
      expect(response.status).to eq (201)
    end

    it "returns the expected attributes in the JSON body" do
      expect(json_response.keys).to match_array(["identifier", "detected_language", "created_at"])
    end

    it "identifies the language as German" do
      expect(json_response["detected_language"]).to eq ("de")
    end
  end

  describe "Create new Spanish message with new session", :type => :request do

    before do
      post '/api/v1/sessions/123456/messages', params: { :text => 'Verde que te quiero verde.
                                                                    Verde viento. Verdes ramas.
                                                                    El barco sobre la mar
                                                                    y el caballo en la montaña.
                                                                    Con la sombra en la cintura
                                                                    ella sueña en su baranda,
                                                                    verde carne, pelo verde,
                                                                    con ojos de fría plata.' }
    end

    it "return created status" do
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
      post '/api/v1/sessions/123456/messages', params: { :text => "Rappelez-vous l'objet que nous vîmes, mon âme,
                                                                    Ce beau matin d'été si doux:
                                                                    Au détour d'un sentier une charogne infâme
                                                                    Sur un lit semé de cailloux," }
    end

    it "returns the proper error" do
      expect(response.status).to eq (422)
    end

  end

  describe "creates reply", :type => :request do
    before do
      post '/api/v1/sessions/123456/messages', params: { :text => 'I’ll work my way from irony to sincerity in the sinking city, a would be Whitman of the vulnerable grid.' }
    end


  end



end
