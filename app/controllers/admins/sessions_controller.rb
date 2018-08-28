class Admins::SessionsController < Admins::ApplicationController
  def sign_in
    user = User.find_by_email(params[:email])
    render json: {status: 1, err_msg: '用户名错误'} and return unless user
    render json: {status: 1, err_msg: '密码错误'} and return unless user.authenticate(params[:password])
    
    user.generate_token
    token = user.get_token
    render json: { status: 0, data: user.simple_hash.merge(token: token) }
  end

  def sign_out
    @current_admin.delete_token!
    render json: { status: 0 }
  end
end