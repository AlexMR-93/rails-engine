require "rails_helper"
require "date"


RSpec.describe(Item, type: :model) do
  describe("Relationships") do
    it { should(belong_to(:merchant)) }
    it { should(have_many(:invoice_items)) }
    it { should(have_many(:invoices).through(:invoice_items)) }
  end

  describe("class method") do
    it("find_all_name") do
      merchant = Merchant.create!(      name: "Alex")
      @item1 = Item.create!(      name: "chips",       description: "brown potatos",       unit_price: 1.2,       merchant_id: merchant.id)
      @item2 = Item.create!(      name: "poopie",       description: "made this up",       unit_price: 1.2,       merchant_id: merchant.id)
      @item3 = Item.create!(      name: "pooptie",       description: "fancy tie ",       unit_price: 1.2,       merchant_id: merchant.id)
      @item4 = Item.create!(      name: "drink",       description: "enery",       unit_price: 1.2,       merchant_id: merchant.id)
      @item5 = Item.create!(      name: "poopily",       description: "new word",       unit_price: 1.6,       merchant_id: merchant.id)
      expect(Item.entire_name("poop")).to(eq([@item2, @item5, @item3]))
    end

    it("min price") do
      merchant = Merchant.create!(      name: "Alex")
      @item1 = Item.create!(      name: "chips",       description: "brown potatos",       unit_price: 1.2,       merchant_id: merchant.id)
      @item2 = Item.create!(      name: "poopie",       description: "made this up",       unit_price: 1.4,       merchant_id: merchant.id)
      @item3 = Item.create!(      name: "pooptie",       description: "fancy tie ",       unit_price: 2.0,       merchant_id: merchant.id)
      @item4 = Item.create!(      name: "drink",       description: "enery",       unit_price: 1.3,       merchant_id: merchant.id)
      @item5 = Item.create!(      name: "poopily",       description: "new word",       unit_price: 1.6,       merchant_id: merchant.id)
      expect(Item.min_price(1.4)).to(eq([@item2, @item5, @item3]))
    end

    it("max price") do
      merchant = Merchant.create!(      name: "Alex")
      @item1 = Item.create!(      name: "chips",       description: "brown potatos",       unit_price: 1.2,       merchant_id: merchant.id)
      @item2 = Item.create!(      name: "poopie",       description: "made this up",       unit_price: 1.4,       merchant_id: merchant.id)
      @item3 = Item.create!(      name: "pooptie",       description: "fancy tie ",       unit_price: 2.0,       merchant_id: merchant.id)
      @item4 = Item.create!(      name: "drink",       description: "enery",       unit_price: 1.3,       merchant_id: merchant.id)
      @item5 = Item.create!(      name: "poopily",       description: "new word",       unit_price: 1.6,       merchant_id: merchant.id)
      expect(Item.max_price(1.4)).to(eq([@item2, @item4, @item1]))
    end

    it("min max price") do
      merchant = Merchant.create!(      name: "Alex")
      @item1 = Item.create!(      name: "chips",       description: "brown potatos",       unit_price: 1.2,       merchant_id: merchant.id)
      @item2 = Item.create!(      name: "poopie",       description: "made this up",       unit_price: 1.4,       merchant_id: merchant.id)
      @item3 = Item.create!(      name: "pooptie",       description: "fancy tie ",       unit_price: 2.0,       merchant_id: merchant.id)
      @item4 = Item.create!(      name: "drink",       description: "enery",       unit_price: 1.3,       merchant_id: merchant.id)
      @item5 = Item.create!(      name: "poopily",       description: "new word",       unit_price: 1.6,       merchant_id: merchant.id)
      expect(Item.min_to_max(1.4, 1.7)).to(eq([@item2, @item5]))
    end
  end
end
