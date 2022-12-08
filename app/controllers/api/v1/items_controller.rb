class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      render(      json: ItemSerializer.new(Item.where(      merchant_id: params[:merchant_id])))
    else
      render(      json: ItemSerializer.new(Item.all))
    end
  end

  def show
    render(    json: ItemSerializer.new(Item.find((params[:id]))))
  end

  def create
    render(    json: ItemSerializer.new(Item.create(item_params)))
  end

  def update
    item = Item.find(params[:id])
    merchant = Merchant.find_by(    id: item_params[:merchant_id])
    updated_item = Item.update(params[:id], item_params)
    render(    json: ItemSerializer.new(item))
  end

  def destroy
    render(    json: (Item.delete(params[:id])))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)

  end
end
