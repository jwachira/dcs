class WaitingListsController < ApplicationController
  resource_controller
  
  def index
    @children = Child.on_waiting_lists
  end
  
  def show
    @child = Child.find(params[:id])
  end
  
  def new
    @family = Family.new
    @family.children.build
    @family.guardians.build
  end
  
  def create
    @family = Family.new(params[:family])
    @family.provider = current_user.provider
    @family.add_children_to_waiting_list
    if @family.save
      flash[:npt]
      redirect_to waiting_lists_url
    else
      render 'new'
    end
  end

end
