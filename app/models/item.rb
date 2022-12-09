class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices,   through: :invoice_items

  def self.entire_name(string)
    where("name ILIKE ?", "%#{string}%").order("name").uniq
  end

  def self.min_price(min)
    where(    unit_price: min..Float::INFINITY).order("unit_price").uniq
  end

  def self.max_price(max)
    where(    unit_price: 0..max).order("unit_price DESC").uniq
  end

  def self.min_to_max(min, max)
    where(    unit_price: min..max).order("unit_price").uniq
  end
end
