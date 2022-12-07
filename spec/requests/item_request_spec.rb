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
  end
end
