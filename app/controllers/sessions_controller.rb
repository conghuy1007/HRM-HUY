class SessionsController < ApplicationloginController
  before_action :validate_login, only: [:new]
  def new
    @user = User.new
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash[:error] = "Invalid username/password "
      redirect_to login_path
    else
      sign_in user
      redirect_to index_path
    end
    
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
