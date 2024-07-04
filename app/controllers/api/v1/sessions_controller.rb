class Api::V1::SessionsController < AuthController
  def create
    user = User.find_or_create_by(user_params)
    if user
      token = encode_token(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "ログインに失敗しました" }, status: :unprocessable_entity
    end
  rescue StandardError => e
    pp e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
