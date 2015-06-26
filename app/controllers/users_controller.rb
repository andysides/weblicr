class UsersController < ApplicationController
  include UsersHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:auth_token] = @user.auth_token
      redirect_to root_url, notice: I18n.t('user.sign_up.success')
    else
      render 'new'
    end
  end

  def edit
    @user = user
    redirect_to root_url, notice: I18n.t('user.edit.access_denied') if
      !can_edit?(user: @user)
  end

  def update
    if user.update_attributes(user_params)
      redirect_to user_path, notice: I18n.t('user.edit.success_message')
    else
      render 'edit'
    end
  end

  def show
    @user = user
  end

  def index
    @users = User.page current_page
  end

  private

  def user
    User.find(params[:id])
  end

  def current_page
    params[:page] || 1
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
