class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  # 画像添付がない場合はサンプル画像を表示
  def get_image(width, height)
    # 「unless」：もし〜でなければ → もし画像が添付されていなければ
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end
