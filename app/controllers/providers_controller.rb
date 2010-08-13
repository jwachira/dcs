class ProvidersController < ApplicationController
  resource_controller
  
  def index
    @search    = Provider.search(params[:search])
    @providers = @search.paginate(:all, :page => params[:page], :per_page => 50)
  end
  
  def create
    @provider = Provider.new(params[:provider])
    @provider.user = current_user
    if @provider.save
      flash[:notice] = "Your daycare profile has been successfully created."
      redirect_to(@provider)
    else
      render 'new'
    end
  end
  
  def update
    @provider = Provider.find(params[:id])
    @provider.attributes = params[:provider]
    @provider.user = current_user
    if @provider.save
      flash[:notice] = "Your profile has been successfully updated."
      redirect_to(@provider)
    else
      render 'edit'
    end
  end
end
