require "rails_helper"


describe("Merchant API") do
  it("sends a list of merhcants(index)") do
    create_list(:merchant, 3)
    get("/api/v1/merchants")
    expect(response).to(be_successful)
    merchants = JSON.parse(response.body,     symbolize_names: true)
    expect(merchants[:data].count).to(eq(3))

    merchants[:data].each do |merchant|
      expect(merchant).to(have_key(:id))
      expect(merchant[:id]).to(be_an(String))
      expect(merchant).to(have_key(:type))
      expect(merchant[:type]).to(be_a(String))
      expect(merchant[:attributes]).to(have_key(:name))
      expect(merchant[:attributes][:name]).to(be_a(String))
    end
  end

  it("can get one merchant by its id(show)") do
    id = create(:merchant).id
    get("/api/v1/merchants/#{id}")
    merchant = JSON.parse(response.body,     symbolize_names: true)
    expect(response).to(be_successful)
    expect(merchant).to(have_key(:id))
    expect(merchant[:id]).to(eq(id))
    expect(merchant).to(have_key(:name))
    expect(merchant[:name]).to(be_a(String))
  end

  it("get all items from a given merchant ID") do
    merchant1 = create(:merchant)
    item1 = create(:item,     description: "aaaa",     unit_price: 1.2,     merchant_id: merchant1.id)
    item2 = create(:item,     description: "bbbb",     unit_price: 1.3,     merchant_id: merchant1.id)
    get("/api/v1/merchants/#{merchant1.id}/items")
    items = JSON.parse(response.body,     symbolize_names: true)
    expect(response).to(be_successful)
    expect(items).to(have_key(:data))

    items[:data].each do |item|
      expect(item).to(have_key(:id))
      expect(item[:id]).to(be_a(String))
      expect(item).to(have_key(:type))
      expect(item[:type]).to(be_a(String))
      expect(item[:attributes]).to(have_key(:name))
      expect(item[:attributes][:name]).to(be_a(String))
      expect(item[:attributes]).to(have_key(:description))
      expect(item[:attributes][:description]).to(be_a(String))
      expect(item[:attributes]).to(have_key(:unit_price))
      expect(item[:attributes][:unit_price]).to(be_a(Float))
      expect(item[:attributes]).to(have_key(:merchant_id))
      expect(item[:attributes][:merchant_id]).to(be_a(Integer))
    end
  end
end
