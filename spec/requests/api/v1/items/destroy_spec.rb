require 'rails_helper'

describe "Items API destroy function" do
  it "Destroys an Item from the DB" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.all.first).to eq(item)

    delete "/api/v1/items/#{item.id}"

    expect(Item.all).to eq([])
  end
end