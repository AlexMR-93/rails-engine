require "rails_helper"


describe("Items API") do
  it("sends a list of items(index)") do
    create_list(:item, 3)
    get("/api/v1/items")
    expect(response).to(be_successful)
    items = JSON.parse(response.body,     symbolize_names: true)
    expect(items[:data].count).to(eq(3))

    items[:data].each do |item|
      expect(item).to(have_key(:id))
      expect(item[:id]).to(be_an(String))
    end
  end

  it("can get one item by its id(show)") do
    id = create(:item).id
    get("/api/v1/items/#{id}")
    item = JSON.parse(response.body,     symbolize_names: true)
    expect(response).to(be_successful)
    expect(item[:data]).to(have_key(:id))
    expect(item[:data][:id]).to(be_a(String))
    expect(item[:data]).to(have_key(:type))
    expect(item[:data][:type]).to(be_a(String))
    expect(item[:data][:attributes]).to(have_key(:name))
    expect(item[:data][:attributes][:name]).to(be_a(String))
    expect(item[:data][:attributes]).to(have_key(:description))
    expect(item[:data][:attributes][:description]).to(be_a(String))
    expect(item[:data][:attributes]).to(have_key(:unit_price))
    expect(item[:data][:attributes][:unit_price]).to(be_a(Float))
    expect(item[:data][:attributes]).to(have_key(:merchant_id))
    expect(item[:data][:attributes][:merchant_id]).to(be_a(Integer))
  end

  it("can create a new Item(create)") do
    id = create(:merchant).id
    item_params = ({name: "Gummy Bear", description: "Sour", unit_price: 1.11, merchant_id: id})
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post("/api/v1/items",     headers: headers,     params: JSON.generate(    item: item_params))
    created_item = Item.last
    expect(response).to(be_successful)
    expect(created_item.name).to(eq(item_params[:name]))
  end

  it("can update an existing item") do
    merchant = create(:merchant)
    id = create(:item).id
    previous_description = Item.last.description
    item_params = {
      name: "AAA",
      description: "Butter",
      unit_price: 11.11,
      merchant_id: merchant.id,
    }
    headers = {"CONTENT_TYPE" => "application/json"}

  # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch("/api/v1/items/#{id}",     headers: headers,     params: JSON.generate({item: item_params}))
    item = Item.find_by(    id: id)
    expect(response).to(be_successful)
    expect(item.description).to_not(eq(previous_description))
    expect(item.description).to(eq("Butter"))
  end

  it("can destroy an item") do
    item = create(:item)
    expect(Item.count).to(eq(1))
    delete("/api/v1/items/#{item.id}")
    expect(response).to(be_successful)
    expect(Item.count).to(eq(0))
    expect { Item.find(item.id) }.to(raise_error(ActiveRecord::RecordNotFound))
  end
end
