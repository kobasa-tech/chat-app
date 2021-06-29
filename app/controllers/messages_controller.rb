class MessagesController < ApplicationController
  def index    
    @message = Message.new
    @room = Room.find(params[:room_id]) #選択したroomのidを取得=選択したroomsテーブルのidのレコード全てを取得している
    @messages = @room.messages.includes(:user)
    # ルームの全てのメッセージを取得。メッセージにはユーザー情報が表示されるためN+1問題を回避。
  end

  def create
    @room = Room.find(params[:room_id]) #選択したroomのidを取得
    @message = @room.messages.new(message_params)
    # room_id(親モデル)に紐作くコメント(子モデル)のインスタンスを生成するには
    # 親モデルのルームidなど.子モデル名(ただし複数形で頭文字が小文字で記述).new
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      # 保存に失敗しても@messagesが定義されていないとエラーになるため記述。
      render :index
    end
    # 新しいインスタンス変数を生成 = 前のインスタンス変数は保存され画面が更新された。ということ
      # インスタンス変数の保存に成功後(@message.save)のredirect_to(取得したroomのインデックスアクションへのパス)は
      # リクエストを送信してindexアクションに向かう指示。
        # indexアクションで新しいインスタンス変数を生成(@message = Message.new)
      # 保存に失敗した場合はrenderにより、リクエストを送信せず直接index.html.erbを表示するので、
      # インスタンス変数は新しく生成されず、createアクションの変数のままになる。
  end

  private
def message_params
  params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  # paramsのデータ(ハッシュの形態)に追加したいデータをmergeで結合させている。
  # {:content=> "(フォームで入力された内容)=(f.text_field :content)", :image=> "選択された画像" ,:user_id=> current_user.id}
end

end
