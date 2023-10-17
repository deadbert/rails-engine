require 'rails_helper'

describe "Item show endpoint" do
  it "shows a singular item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
 
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(item).to be_a(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price].to_i).to be_a(Integer)

  end
end