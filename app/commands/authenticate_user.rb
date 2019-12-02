class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    #user = User.find_by_email(email)
    user = User.find_by(email: email, password: password, status: true)
    return user if user 

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end