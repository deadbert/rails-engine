require "rails_helper"

describe "Items create endpoint" do
  it "creates a new item in the items table from params passed in request body" do
    merchant = create(:merchant)

    body = {
      "name": "Thingy",
      "description": "Does Thingy",
      "unit_price": 200,
      "merchant_id": "#{merchant.id}"
    }
    post "/api/v1/items", params: body

    expect(Item.first.name).to eq("Thingy")
    expect(Item.first.description).to eq("Does Thingy")
    expect(Item.first.unit_price).to eq(200)
    expect(Item.first.merchant_id).to eq(merchant.id)
  end

  it "returns a status code failed if not all required params are present" do
    merchant = create(:merchant)

    body = {
      "name": "Thingy",
      "description": "Does Thingy",
      "unit_price": 200
    }
    post "/api/v1/items", params: body

    expect(response).to_not be_successful
  end
end