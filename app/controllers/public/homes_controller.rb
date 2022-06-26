class Public::HomesController < ApplicationController

  def top
    @items = Item.all
    #idの降順に並び替えた結果の４件を取得
    @items = @items.order(id: :DESC).limit(4)
  end

  def about
  end
end
