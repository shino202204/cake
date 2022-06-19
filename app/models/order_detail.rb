class OrderDetail < ApplicationRecord
  # アソシエーション
  belongs_to :item
  belongs_to :order

  # 支払方法 0:製作不可, 1:製作待ち, 2:製作中, 3:製作完了
  enum making_statuses: {not_available: 0, awaiting_manufacture: 1, under_manufacture: 2, completion: 3}
end
