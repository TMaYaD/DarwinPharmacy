class PurchaseBillsController < ApplicationController
  filter_resource_access

  # GET /purchase_bills
  # GET /purchase_bills.xml
  def index
    params[:iDisplayLength] ||= 10
    params[:iDisplayStart] ||= 0
    params[:sSort] ||='due_date desc'
    params[:sColumns] ||= '*'
    conditions = [ 'bill_number LIKE :q
      OR suppliers.name LIKE :q
      ', { :q => "%#{params[:sSearch]}%" } ]

    @purchase_bills = PurchaseBill.all(
        :select => params[:sColumns],
        :limit => params[:iDisplayLength],
        :offset => params[:iDisplayStart],
        :order => params[:sSort],
        :joins => :supplier,
        :conditions => conditions
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchase_bills }
      format.js  { render :json => {
        :sEcho => params[:sEcho],
        :iTotalRecords => PurchaseBill.count,
        :iTotalDisplayRecords => PurchaseBill.count(:joins => :supplier, :conditions => conditions),
        :aColumns => { 'purchase_bills.id' => 'id', 'suppliers.name' => 'name' },
        :ajData => @purchase_bills,
      }}
    end
  end

  # GET /purchase_bills/1
  # GET /purchase_bills/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_bill }
    end
  end

  # GET /purchase_bills/new
  # GET /purchase_bills/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_bill }
    end
  end

  # GET /purchase_bills/1/edit
  def edit
  end

  # POST /purchase_bills
  # POST /purchase_bills.xml
  def create
    respond_to do |format|
      if @purchase_bill.save
        flash[:notice] = 'PurchaseBill was successfully created.'
        format.html { redirect_to(@purchase_bill) }
        format.xml  { render :xml => @purchase_bill, :status => :created, :location => @purchase_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_bills/1
  # PUT /purchase_bills/1.xml
  def update
    respond_to do |format|
      if @purchase_bill.update_attributes(params[:purchase_bill])
        flash[:notice] = 'PurchaseBill was successfully updated.'
        format.html { redirect_to(@purchase_bill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_bills/1
  # DELETE /purchase_bills/1.xml
  def destroy
    @purchase_bill.destroy

    respond_to do |format|
      format.html { redirect_to(purchase_bills_url) }
      format.xml  { head :ok }
    end
  end
end
