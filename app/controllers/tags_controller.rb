class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_subscription
  before_action :set_user_email_in_session, only: [:create_subscription]
  before_action :check_user_already_subscribed, only: [:subscribe,:create_subscription]

  def subscribe
    @tag_id = params[:tag_id]
    if user_has_email_in_session
      respond_to do |format|
        format.js { render 'subscribe.js.erb', locals: { modal: 'confirm_subscription_modal' } }
      end
    else
      respond_to do |format|
        format.js { render 'subscribe.js.erb', locals: { modal: 'session_email_register' } }
      end
    end
  end

  def create_subscription
    @subscription = Subscription.where(email:@user_email,tag_id:params[:tag_id]).first_or_create!
    respond_to do |format|
      format.js { render 'subscribe.js.erb', locals: { modal: 'subscription_success' } }
    end
  end

  private



  def check_user_already_subscribed
    if cookies[:session_email] && Subscription.where(email:cookies[:session_email],tag_id:params[:tag_id]).exists?

      respond_to do |format|
        format.js { render 'subscribe.js.erb', locals: { modal: 'already_subscribed_modal' } }
      end
    end
  end


  def user_has_email_in_session
    cookies[:session_email]
  end

  def set_user_email_in_session
    unless cookies[:session_email]
      cookies[:session_email] = params[:email]
    end
    @user_email = cookies[:session_email]
  end
end
