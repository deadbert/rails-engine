require 'rails_helper'

describe "Items search endpoints" do
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

    it "can accept both a min and max parameter for price search" do
      guy = create(:merchant)
      item1 = Item.create!(name: "Thingy", description: "Does Thingy", unit_price: 20, merchant_id: guy.id)
      item2 = Item.create!(name: "Zippy", description: "Does Zipping", unit_price: 200, merchant_id: guy.id)
      item3 = Item.create!(name: "Whizzer", description: "Does Whizzing", unit_price: 550, merchant_id: guy.id)

      get "/api/v1/items/find?min_price=50&max_price=500"

      expect(response.body).to eq(ItemSerializer.new(item2).to_json)
    end

    it "doesn't accept name search param with min or max search param" do

      get "/api/v1/items/find?min_price=50&name=ted"

      expect(response.body).to eq({errors: "Invalid Parameters"}.to_json)
    end
  end
end