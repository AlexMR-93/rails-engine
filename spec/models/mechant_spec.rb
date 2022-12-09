require "rails_helper"


RSpec.describe(Merchant, type: :model) do
  describe("Relationships") do
    it { should(have_many(:items)) }
  end

  describe("class method") do
    it("find_first") do
      merchant1 = Merchant.create!(      name: "Alex")
      merchant2 = Merchant.create!(      name: "ppbeans")
      merchant3 = Merchant.create!(      name: "beanies")
      expect(Merchant.find_first("bean")).to(eq(merchant3))
    end
  end
end
