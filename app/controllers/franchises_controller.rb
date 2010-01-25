class FranchisesController < ApplicationController
  filter_resource_access

  # GET /franchises
  # GET /franchises.xml
  def index
    @franchises = Franchise.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @franchises }
    end
  end

  # GET /franchises/1
  # GET /franchises/1.xml
  def show
    @franchise = Franchise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @franchise }
    end
  end

  # GET /franchises/new
  # GET /franchises/new.xml
  def new
    @franchise = Franchise.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @franchise }
    end
  end

  # GET /franchises/1/edit
  def edit
    @franchise = Franchise.find(params[:id])
  end

  # POST /franchises
  # POST /franchises.xml
  def create
    @franchise = Franchise.new(params[:franchise])

    respond_to do |format|
      if @franchise.save
        flash[:notice] = 'Franchise was successfully created.'
        format.html { redirect_to(@franchise) }
        format.xml  { render :xml => @franchise, :status => :created, :location => @franchise }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @franchise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /franchises/1
  # PUT /franchises/1.xml
  def update
    @franchise = Franchise.find(params[:id])

    respond_to do |format|
      if @franchise.update_attributes(params[:franchise])
        flash[:notice] = 'Franchise was successfully updated.'
        format.html { redirect_to(@franchise) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @franchise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /franchises/1
  # DELETE /franchises/1.xml
  def destroy
    @franchise = Franchise.find(params[:id])
    @franchise.destroy

    respond_to do |format|
      format.html { redirect_to(franchises_url) }
      format.xml  { head :ok }
    end
  end
end
