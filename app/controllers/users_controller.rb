class UsersController < ApplicationController
   include SessionsHelper
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    
    
  def new
    @user = User.new
  end
  
  def home
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find_by(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      log_in @user
      redirect_to @user
    else
      render "edit"
    end
  end
        
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :rank, :password, :password_confirmation)
    end
    
    #beforeアクション　
    def logged_in_user
      unless logged_in?
      store_location
        
      flash[:danger] = "log inしてください"
      redirect_to login_url
      end
    end
end
