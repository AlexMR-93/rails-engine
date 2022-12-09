class Api::V1::ItemsController < ApplicationController
  def index
    render(    json: ItemSerializer.new(Item.all))
  end

  def show
    render(    json: ItemSerializer.new(Item.find((params[:id]))))
  end

  def create
    render(    json: ItemSerializer.new(Item.create(item_params)),     status: 201)
  end

  def update
    updated_item = Item.update(params[:id], item_params)
    Merchant.find(params[:item][:merchant_id]) if params[:item][:merchant_id]
    render(    json: ItemSerializer.new(updated_item))
  end

  def destroy
    render(    json: (Item.delete(params[:id])))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)

  end
end
