class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :snakeize_params

  private

  def authenticate_request
    header = request.headers['Authorization']
    return if header == 'undefined' || header.blank?
    
    header = header.split(' ').last
    begin
      decoded = AuthToken.decode(header)
      @current_user = User.find(decoded[:user_id]) if decoded
    rescue JWT::DecodeError
      render json: { error: 'トークンが正しくありません' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'ユーザーが見つかりません' }, status: :unauthorized
    rescue => e
      render json: { error: '不明なエラーです', message: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def snakeize_params
    request.parameters.deep_transform_keys!(&:underscore)
  end
end
