class OrderDetail < ApplicationRecord
  # アソシエーション
  belongs_to :item
  belongs_to :order

  # 支払方法 0:クレジットカード, 1:銀行振込
  enum making_status: {not_available: 0, awaiting: 1, under: 2, completion: 3}
end
