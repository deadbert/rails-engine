require 'rails_helper'

describe "Merchant show 1 endpoint" do
  it "sends info on one merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
  
  it "gives 404 when an invalid merchant id is selected" do
     get "/api/v1/merchants/-1"

  end
end