require 'rails_helper'

describe "Merchants search API endpoint" do
  describe "/find" do
    it "returns a single item which matches a search term" do
      merchant1 = Merchant.create!(name: "Daniel")
      merchant2 = Merchant.create!(name: "Brandon")
      merchant3 = Merchant.create!(name: "Gavin")

      get "/api/v1/merchants/find?name=Dan"

      expect(response.body).to eq(MerchantSerializer.new(merchant1).to_json)
    end

    it "returns an json with data: [] when no matches found, status 200" do
      merchant1 = Merchant.create!(name: "Daniel")
      merchant2 = Merchant.create!(name: "Brandon")
      merchant3 = Merchant.create!(name: "Gavin")

      get "/api/v1/merchants/find?name=Zane"

      expect(response.body).to eq({data: {attributes: []}}.to_json)
    end
  end

  describe "/find_all" do
    it "returns all merchants wich match a search term" do
      merchant1 = Merchant.create!(name: "Nic")
      merchant2 = Merchant.create!(name: "Nicholas")
      merchant3 = Merchant.create!(name: "Niche")

      get "/api/v1/merchants/find_all?name=Nic"
      
      expect(response.body).to eq(MerchantSerializer.new([merchant1, merchant2, merchant3]).to_json)
    end
  end
end