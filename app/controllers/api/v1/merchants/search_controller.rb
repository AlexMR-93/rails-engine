class Api::V1::Merchants::SearchController < ApplicationController
  def index
    name_sort = Merchant.find_first(params[:name])
    render(    json: MerchantSerializer.new(name_sort))
  end
end
