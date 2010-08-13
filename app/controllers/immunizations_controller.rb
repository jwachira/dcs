class ImmunizationsController < ApplicationController
  # GET /immunizations
  # GET /immunizations.xml
  def index
    @immunizations = Immunization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @immunizations }
    end
  end

  # GET /immunizations/1
  # GET /immunizations/1.xml
  def show
    @immunization = Immunization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @immunization }
    end
  end

  # GET /immunizations/new
  # GET /immunizations/new.xml
  def new
    @immunization = Immunization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @immunization }
    end
  end

  # GET /immunizations/1/edit
  def edit
    @immunization = Immunization.find(params[:id])
  end

  # POST /immunizations
  # POST /immunizations.xml
  def create
    @immunization = Immunization.new(params[:immunization])

    respond_to do |format|
      if @immunization.save
        format.html { redirect_to(@immunization, :notice => 'Immunization was successfully created.') }
        format.xml  { render :xml => @immunization, :status => :created, :location => @immunization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @immunization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /immunizations/1
  # PUT /immunizations/1.xml
  def update
    @immunization = Immunization.find(params[:id])

    respond_to do |format|
      if @immunization.update_attributes(params[:immunization])
        format.html { redirect_to(@immunization, :notice => 'Immunization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @immunization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /immunizations/1
  # DELETE /immunizations/1.xml
  def destroy
    @immunization = Immunization.find(params[:id])
    @immunization.destroy

    respond_to do |format|
      format.html { redirect_to(immunizations_url) }
      format.xml  { head :ok }
    end
  end
end
