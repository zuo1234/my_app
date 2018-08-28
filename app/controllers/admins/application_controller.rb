class Admins::ApplicationController < ApplicationController
  before_action :authenticate_admin, except: [:sign_in]

  def authenticate_admin
    Rails.logger.info 'headers begin =============='
    Rails.logger.info request.headers
    Rails.logger.info 'headers end ================'

    email = request.headers['HTTP_X_EMAIL']
    token  = request.headers['HTTP_X_TOKEN']
    render json: { status_text: '需要传递邮箱地址' }, status: 401 and return if email.blank?

    current_user = User.find_by(email: email)
    render json: { status_text: '非法用户登陆!!!' }, status: 401 and return if current_user.nil?

    auth_info = current_user.auth_token?(token)
    render json: { status_text: auth_info[:status_text] }, status: 401 and return if auth_info[:status] == 1

    @current_user = current_user
  end

end