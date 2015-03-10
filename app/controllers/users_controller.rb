class UsersController < ApplicationController
  include ActiveModel::ForbiddenAttributesProtection

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(allowed_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @id = params[:id]
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def allowed_params
      params.require(:user).permit(:name,:age)
    end

end
