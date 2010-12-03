module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
    return_val = user_from_remember_token
  end
  
  def signed_in?
    puts "inside signed_in? method and current_user is #{current_user}"
    puts "signed_in? method. value is #{!current_user.nil?}"
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
end
