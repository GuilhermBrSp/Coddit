class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_user_token_id

  private

  def check_user_token_id
    if cookies[:token_id]
      @token_id = cookies[:token_id]
    else
      cookies[:token_id] = generate_token_id
      @token_id = cookies[:token_id]
    end
  end

  def generate_token_id
    if Favorite.last && Favorite.last.id
      Favorite.last.id + 1
    else
      1
    end
  end
end
