require 'rails_helper'

describe "Items search enpoints" do
  describe "Items /find endpoint" do
    it "returns 1 item that matches the keyword query" do
      guy = create(:merchant)
      item1 = Item.create!(name: "Thingy", description: "Does Thingy", unit_price: 200, merchant_id: guy.id)
      item2 = Item.create!(name: "Zippy", description: "Does Zipping", unit_price: 200, merchant_id: guy.id)
      item3 = Item.create!(name: "Whizzer", description: "Does Whizzing", unit_price: 200, merchant_id: guy.id)

      get "/api/v1/items/find?name=thin"

      expect(response.body).to eq(ItemSerializer.new(item1).to_json)
    end

    it "returns empty data if no items match keyword query" do

      get "/api/v1/items/find?name=thin"

      expect(response.body).to eq({data: {attributes: []}}.to_json)
    end
  end
end