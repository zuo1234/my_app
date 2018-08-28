class User < ApplicationRecord
  has_secure_password
  has_one :api_token

  def simple_hash
    {
      email: email,
      name: name,
    }
  end

  def generate_token
    api_token = ApiToken.find_or_create_by(user_id: self.id)
    api_token.token = SecureRandom.urlsafe_base64(64)
    api_token.expired_at = Time.now.since(1.days)
    api_token.save
  end

  def get_token
    api_token&.token
  end

  def auth_token?(token)
    return { status: 1, status_text: '没有找到登录信息' } if api_token.nil?
    return { status: 1, status_text: 'token无效' } if token != api_token.token
    expired_at = api_token&.expired_at

    return { status: 1, status_text: 'token已经失效' } if expired_at.nil? || expired_at < Time.now
    { status: 0 }
  end

  def delete_token!
    api_token.try(:destroy)
  end

end
