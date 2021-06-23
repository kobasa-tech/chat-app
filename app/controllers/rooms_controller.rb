class RoomsController < ApplicationController
  
  def index    
  end
  
  def new
    @room = Room.new
  end

  def create
    # ここにbinding.pryを記述してブラウザでフォーム情報を送信すると、ターミナルのサーバーが止まる。
    # そこにparamsを指定するとパラメーターの内容を見ることができる。
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
    # paramsのデータのうち、roomキー(roomモデル)のバリューであるnameキーのバリューとuser_idsキーの配列バリューのみ取得を許可している。
  end
end
