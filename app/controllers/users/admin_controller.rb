class Users::AdminController < ApplicationController

  def index
    render json: User.all
  end

  def create
    logger.debug safe_params
    head :ok
  end

  def update
    @user = User.find safe_params['id']
    if @user.update safe_params.select {|k,v| ['first_name', 'last_name', 'role'].include?(k)}
      render :show, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @user = User.find safe_params['id']
      @user.destroy
      head :ok
    rescue
      head :bad_request
    end
  end

  private
  def safe_params
    params.require(:admin).permit(:id, :email, :first_name, :last_name, :group_id, :role)
  end
end