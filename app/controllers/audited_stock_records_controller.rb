class AuditedStockRecordsController < ApplicationController
  filter_resource_access

  # GET /audited_stock_records
  def index
    @search = RunningStockRecord.ascend_by_product_batch_product_name.search(params[:search])
    @running_stock_records = @search.paginate(:page => params[:page], :per_page => 40)
  end

  # GET /audited_stock_records/1
  def show
  end

  # GET /audited_stock_records/new
  def new
    @audited_stock_records = Array.new(10) { AuditedStockRecord.new }
  end

  # GET /audited_stock_records/1/edit
  def edit
  end

  # POST /audited_stock_records
  def create
    @audited_stock_records = params[:audited_stock_records].values.collect { |audited_stock_record| AuditedStockRecord.new(audited_stock_record) }
    if @audited_stock_records.all?(&:valid?)
      @audited_stock_records.each(&:save!)
      flash[:notice] = 'AuditedStockRecord was successfully created.'
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  # PUT /audited_stock_records/1
  def update
    if @audited_stock_record.update_attributes(params[:audited_stock_record])
      flash[:notice] = 'AuditedStockRecord was successfully updated.'
      redirect_to(@audited_stock_record)
    else
      render :action => "edit"
    end
  end

  # DELETE /audited_stock_records/1
  def destroy
    @audited_stock_record.destroy

    redirect_to(audited_stock_records_url)
  end
end
