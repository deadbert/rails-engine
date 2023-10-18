class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.valid_id?(params[:merchant_id])
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    else
      head 404
      response.body = {errors: "Page not found"}.to_json
    end
  end
end