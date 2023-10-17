class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)
    if item.save
      head 201
      response.body = ItemSerializer.new(item).to_json
    else
      head 400
      response.body = item.error_message.to_json
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end