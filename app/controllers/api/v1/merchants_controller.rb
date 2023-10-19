class Api::V1::MerchantsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception, 404)), status: :not_found
    end
  end
end