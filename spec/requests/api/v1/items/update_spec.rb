require 'rails_helper'

describe "Item Update endpoint" do
  it "Updates an item from parameters passed in the body of a patch request" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    body = {
      "name": "Thingy",
      "description": "Does Thingy",
      "unit_price": 200,
      "merchant_id": "#{merchant.id}"
    }

    patch "/api/v1/items/#{item.id}", params: body

    expect(Item.first.name).to eq("Thingy")
    expect(Item.first.description).to eq("Does Thingy")
    expect(Item.first.unit_price).to eq(200)
    expect(Item.first.merchant_id).to eq(merchant.id)
  end

  it "Updates even if not all parameters are provided" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    body = {
      "name": "Thingy",
      "description": "Does Thingy",
      "unit_price": 200
    }

    patch "/api/v1/items/#{item.id}", params: body

    expect(Item.first.name).to eq("Thingy")
    expect(Item.first.description).to eq("Does Thingy")
    expect(Item.first.unit_price).to eq(200)
    expect(Item.first.merchant_id).to eq(merchant.id)
  end
end