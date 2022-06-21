class OrderDetail < ApplicationRecord
  # アソシエーション
  belongs_to :item
  belongs_to :order

  # 支払方法 0:製作不可, 1:製作待ち, 2:製作中, 3:製作完了
  enum making_status: {not_available: 0, awaiting_manufacture: 1, under_manufacture: 2, completion: 3}

  # 製作ステータス
  def return_making_statuses
    result = ''
    if making_status == 'not_available'
      result = OrderDetail.making_statuses_i18n[:not_available]
    elsif making_status == 'awaiting_manufacture'
      result = OrderDetail.making_statuses_i18n[:awaiting_manufacture]
    elsif making_status == 'under_manufacture'
      result = OrderDetail.making_statuses_i18n[:under_manufacture]
    elsif making_status == 'completion'
      result = OrderDetail.making_statuses_i18n[:completion]
    end
    return result
  end
end
