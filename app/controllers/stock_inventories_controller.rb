class StockInventoriesController < ApplicationController
  filter_resource_access

  # GET /stock_inventories
  # GET /stock_inventories.xml
  def index
    @search = StockInventory.ascend_by_product_batch_product_name.search(params[:search])
    @stock_inventories = @search.paginate(:page => params[:page], :per_page => 40)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stock_inventories }
    end
  end

  # GET /stock_inventories/1
  # GET /stock_inventories/1.xml
  def show
    @stock_inventory = StockInventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock_inventory }
    end
  end

  # GET /stock_inventories/new
  # GET /stock_inventories/new.xml
  def new
    @stock_inventory = StockInventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stock_inventory }
    end
  end

  # GET /stock_inventories/1/edit
  def edit
    @stock_inventory = StockInventory.find(params[:id])
  end

  # POST /stock_inventories
  # POST /stock_inventories.xml
  def create
    @stock_inventory = StockInventory.new(params[:stock_inventory])

    respond_to do |format|
      if @stock_inventory.save
        flash[:notice] = 'StockInventory was successfully created.'
        format.html { redirect_to(@stock_inventory) }
        format.xml  { render :xml => @stock_inventory, :status => :created, :location => @stock_inventory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stock_inventory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stock_inventories/1
  # PUT /stock_inventories/1.xml
  def update
    @stock_inventory = StockInventory.find(params[:id])

    respond_to do |format|
      if @stock_inventory.update_attributes(params[:stock_inventory])
        flash[:notice] = 'StockInventory was successfully updated.'
        format.html { redirect_to(@stock_inventory) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock_inventory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_inventories/1
  # DELETE /stock_inventories/1.xml
  def destroy
    @stock_inventory = StockInventory.find(params[:id])
    @stock_inventory.destroy

    respond_to do |format|
      format.html { redirect_to(stock_inventories_url) }
      format.xml  { head :ok }
    end
  end
end
