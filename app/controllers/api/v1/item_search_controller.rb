class Api::V1::ItemSearchController < ApplicationController
  def find
    items = search_selector
    if !items.empty?
      render json: ItemSerializer.new(items.first)
    else
      render json: {data: {attributes: []}}
    end
  end

  def find_all
    items = search_selector
    if !items.empty?
      render json: ItemSerializer.new(items)
    else
      render json: {data: []}
    end
  end

  private

  def search_selector
    if params[:name]
      return Item.search_name(params[:name])
    elsif params[:min_price]
      return Item.search_min_price(params[:min_price])
    elsif params[:max_price]
      return Item.search_min_price(params[:max_price])
    end
  end
end