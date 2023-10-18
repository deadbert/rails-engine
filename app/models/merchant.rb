class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.valid_id?(id)
    ids = Merchant.all.pluck('id')
    if ids.include?(id.to_i)
      true
    else
      false
    end
  end
end