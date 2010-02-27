class UsersController < ApplicationController
  filter_access_to :all
  filter_access_to :edit, :update, :attribute_check => true

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    
    ## need to limit role editing.
    if permitted_to?(:set_role, @user)
      @user.role = params[:user][:role]
    end
    
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(@user)
    else
      render :action => "new"
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    @user.email = params[:user][:email]
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    
    ## need to limit role editing.
    if permitted_to?(:set_role, @user)
      @user.role = params[:user][:role]
    end
    
    if @user.save
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user)
    else
      render :action => "edit"
    end
  end
  
  # GET /users/1/delete
  def delete
    @user = User.find(params[:id])
  end
  
  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to(users_url)
  end
end
