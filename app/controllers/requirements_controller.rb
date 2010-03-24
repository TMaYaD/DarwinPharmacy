class RequirementsController < ApplicationController
  filter_resource_access

# GET /requirements
  def index
    @requirements = Requirement.all
  end

  # GET /requirements/1
  def show
  end

  # GET /requirements/new
  def new
  end

  # GET /requirements/1/edit
  def edit
  end

  # POST /requirements
  def create
    if @requirement.save
      flash[:notice] = 'Requirement was successfully created.'
      redirect_to(@requirement)
    else
      render :action => "new"
    end
  end

  # PUT /requirements/1
  def update
    if @requirement.update_attributes(params[:requirement])
      flash[:notice] = 'Requirement was successfully updated.'
      redirect_to(@requirement)
    else
      render :action => "edit"
    end
  end

  # DELETE /requirements/1
  def destroy
    @requirement.destroy

    redirect_to(requirements_url)
  end
end
