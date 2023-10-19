class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.search_name(query)
    where('lower(name) LIKE ?', "%#{query.downcase}%")
  end

  def self.search_min_price(query)
    where('unit_price >= ?', "#{query}").order('name')
  end

  def self.search_max_price(query)
    where('unit_price <= ?', "#{query}").order('name')
  end

  def self.search_price_range(min, max)
    where('unit_price >= ?', min)
    .where('unit_price <= ?', max)
    .order('name')
  end
end