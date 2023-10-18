require 'rails_helper'

describe "Item --> Merchant relationship API endpoint" do
  it "returns info on the Merchant associated with a specific item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    expect(response.body).to eq(MerchantSerializer.new(merchant).to_json)
  end
end