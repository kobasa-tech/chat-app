class ApplicationController < ActionController::Base
  before_action :authenticate_user!
    # before_action :アクション実行前に処理したいメソッド
    # authenticate_user!メソッド ログインしていないユーザーをログイン画面に遷移させる
  before_action :configure_permitted_parameters, if: :devise_controller?
    # ifオプションでdeviseコントローラーのみconfigure_permitted_parametersメソッド(private内のメソッド)を読み込ませている

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizerのpermitメソッドの引数は(:処理名(ログイン、新規登録など), keys: [:フォーム部分のname属性値=カラム名])で記述する。
    # サインアップ時にDBにnameカラムを登録できるようにしている。この記述がなければ登録できない。
    # ストロングパラメーター(受け取るパラメーターを制限)は他の部分に干渉させたくないためprivateに記述。
  end
end
