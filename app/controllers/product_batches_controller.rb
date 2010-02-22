class ProductBatchesController < ApplicationController
  filter_resource_access :additional_collection => :autocomplete

  # GET /product_batches
  # GET /product_batches.xml
  def index
    @search = ProductBatch.search(params[:search])
    @product_batches = @search.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_batches }
    end
  end

  # GET /product_batches/1
  # GET /product_batches/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_batch }
    end
  end

  # GET /product_batches/new
  # GET /product_batches/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_batch }
    end
  end

  # GET /product_batches/1/edit
  def edit
  end

  # POST /product_batches
  # POST /product_batches.xml
  def create
    respond_to do |format|
      if @product_batch.save
        flash[:notice] = 'ProductBatch was successfully created.'
        format.html { redirect_to(@product_batch) }
        format.xml  { render :xml => @product_batch, :status => :created, :location => @product_batch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_batch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_batches/1
  # PUT /product_batches/1.xml
  def update
    respond_to do |format|
      if @product_batch.update_attributes(params[:product_batch])
        flash[:notice] = 'ProductBatch was successfully updated.'
        format.html { redirect_to(@product_batch) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_batch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_batches/1
  # DELETE /product_batches/1.xml
  def destroy
    @product_batch.destroy

    respond_to do |format|
      format.html { redirect_to(product_batches_url) }
      format.xml  { head :ok }
    end
  end

  def autocomplete
    @product_batches = ProductBatch.all(
      :conditions => [ "batch_code LIKE :q AND product_id = :product_id", {:q => "%#{params[:q]}%", :product_id => params[:product_id] } ],
      :limit => params[:limit]
    )
    render :layout => false, :content_type => 'text/plain'
  end
end
