class SaleBillsController < ApplicationController
  filter_resource_access

  # GET /sale_bills
  # GET /sale_bills.xml
  def index
    params[:iDisplayLength] ||= 10
    params[:iDisplayStart] ||= 0
    params[:sSort] ||='sale_bills.created_at desc'
    params[:sColumns] ||= '*'
    conditions = [ 'sale_bills.id LIKE :q
      OR franchises.name LIKE :q
      ', { :q => "%#{params[:sSearch]}%" } ]

    @sale_bills = SaleBill.all(
        :select => params[:sColumns],
        :limit => params[:iDisplayLength],
        :offset => params[:iDisplayStart],
        :order => params[:sSort],
        :joins => :franchise,
        :conditions => conditions
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sale_bills }
      format.js  { render :json => {
        :sEcho => params[:sEcho],
        :iTotalRecords => SaleBill.count,
        :iTotalDisplayRecords => SaleBill.count(:joins => :franchise, :conditions => conditions),
        :aColumns => { 'sale_bills.id' => 'id', 'sale_bills.created_at' => 'created_at', 'franchises.name' => 'name' },
        :ajData => @sale_bills,
      }}

    end
  end

  # GET /sale_bills/1
  # GET /sale_bills/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale_bill }
    end
  end

  # GET /sale_bills/new
  # GET /sale_bills/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale_bill }
    end
  end

  # GET /sale_bills/1/edit
  def edit
  end

  # POST /sale_bills
  # POST /sale_bills.xml
  def create
    respond_to do |format|
      if @sale_bill.save
        flash[:notice] = 'SaleBill was successfully created.'
        format.html { redirect_to(@sale_bill) }
        format.xml  { render :xml => @sale_bill, :status => :created, :location => @sale_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_bills/1
  # PUT /sale_bills/1.xml
  def update
    respond_to do |format|
      if @sale_bill.update_attributes(params[:sale_bill])
        flash[:notice] = 'SaleBill was successfully updated.'
        format.html { redirect_to(@sale_bill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_bills/1
  # DELETE /sale_bills/1.xml
  def destroy
    @sale_bill.destroy

    respond_to do |format|
      format.html { redirect_to(sale_bills_url) }
      format.xml  { head :ok }
    end
  end
end
