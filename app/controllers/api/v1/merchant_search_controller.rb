class Api::V1::MerchantSearchController < ApplicationController
  def find
    merchants = Merchant.search(params[:name])
    if !merchants.empty?
      render json: MerchantSerializer.new(merchants.first)
    else
      render json: {data: {attributes: []}}
    end
  end

  def find_all
    merchants = Merchant.search(params[:name])
    if !merchants.empty?
      render json: MerchantSerializer.new(merchants)
    else
      render json: {data: []}
    end
  end
end