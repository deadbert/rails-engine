class Api::V1::MerchantSearchController < ApplicationController
  def find
    merchants = Merchant.search_one(params[:name])
    if !merchants.empty?
      render json: MerchantSerializer.new(merchants.first)
    else
      render json: {data: {attributes: []}}
    end
  end
end