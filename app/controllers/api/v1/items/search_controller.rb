class Api::V1::Items::SearchController < ApplicationController
  def index
    if (params[:name])
      find_name = Item.entire_name(params[:name])
      render(      json: ItemSerializer.new(find_name))
    elsif params[:min_price] && !params[:max_price]
      find_min_price = Item.min_price(params[:min_price])
      render(      json: ItemSerializer.new(min_price))
    elsif params[:max_price] && !params[:min_price]
      find_max_price = Item.max_price(params[:max_price])
      render(      json: ItemSerializer.new(max_price))
    elsif (params[:max_price] && params[:min_price])
      find_min_max = Item.max_price(params[:min_price], params[:max_price])
      render(      json: ItemSerializer.min_to_max(find_min_max))
    else
      render(      json: {error: "Error "},       status: 404)
    end
  end
end
