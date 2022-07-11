class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #authenticateメソッド：*誤ったパスワードの場合→ falseを返す/正しいパスワードの場合→ そのユーザーを返す
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user # user_url(user) モデルオブジェクトが渡されると自動でidにリンク＋_urlヘルパーは省略可+Rubyでは()は省略可
    else
      # エラーメッセージを作成する
      flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
