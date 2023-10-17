require 'rails_helper'

describe "Merchant items index endpoint" do
  it "shows all items for 1 merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
 
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items).to be_a(Array)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)
  
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
  
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
  
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price].to_i).to be_a(Integer)
    end
  end
end