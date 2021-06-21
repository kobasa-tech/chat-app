class UsersController < ApplicationController

  def edit    
    # editアクションはビュー表示のみ
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
      # 現在のユーザー情報を更新できたら、ユーザー情報を上書きしてチャット画面に遷移する。
    else
      render :edit
      # ユーザー情報を更新できなければ、ユーザー情報は上書きされずにeditアクションを行う。
      # render action: :edit のactionオプションの記述は省略できる
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
    # 取得する編集内容は「userテーブルのname,emailの値のみ」の制約をかける
  end

end
