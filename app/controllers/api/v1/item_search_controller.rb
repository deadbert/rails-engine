class Api::V1::ItemSearchController < ApplicationController
  def find
    if valid_params?
      items = search_selector
      if !items.empty?
        render json: ItemSerializer.new(items.first)
      else
        render json: {data: {attributes: []}}
      end
    else
      head 400
      response.body = {errors: "Invalid Parameters"}.to_json
    end
  end

  def find_all
    if valid_params?
      items = search_selector
      if !items.empty?
        render json: ItemSerializer.new(items)
      else
        render json: {data: []}
      end
    else
      head 400
      response.body = {errors: "Invalid Parameters"}.to_json
    end
  end

  private

  def search_selector
    if params[:name]
      return Item.search_name(params[:name])
    elsif params[:min_price] && !params[:max_price]
      return Item.search_min_price(params[:min_price])
    elsif params[:max_price] && !params[:min_price]
      return Item.search_max_price(params[:max_price])
    elsif params[:min_price] && params[:max_price]
      return Item.search_price_range(params[:min_price], params[:max_price])
    end
  end

  def valid_params?
    if name_and_price_invalid? || max_min_invalid?
      false
    else
      true
    end
  end

  def name_and_price_invalid?
   true if (params[:name] && (params[:min_price] || params[:max_price]))
  end

  def max_min_invalid?
    true if (params[:max_price].to_i < 0 || params[:min_price].to_i < 0)
  end
end