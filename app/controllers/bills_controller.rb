class BillsController < ApplicationController
  filter_resource_access

  # GET /bills
  # GET /bills.xml
  def index
    params[:iDisplayLength] ||= 10
    params[:iDisplayStart] ||= 0
    params[:sSort] ||='bills.created_at desc'
    params[:sColumns] ||= '*'
    conditions = [ 'bills.id LIKE :q
      OR franchises.name LIKE :q
      OR customers.name LIKE :q
      ', { :q => "%#{params[:sSearch]}%" } ]

    @bills = Bill.with_permissions_to(:show).all(
        :select => params[:sColumns],
        :limit => params[:iDisplayLength],
        :offset => params[:iDisplayStart],
        :order => params[:sSort],
        :joins => [:franchise, :customer],
        :conditions => conditions
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
      format.js  { render :json => {
        :sEcho => params[:sEcho],
        :iTotalRecords => Bill.with_permissions_to(:show).count,
        :iTotalDisplayRecords => Bill.with_permissions_to(:show).count(:joins => [:franchise, :customer], :conditions => conditions),
        :aColumns => { 'bills.id' => 'id', 'bills.created_at' => 'created_at', 'franchises.name f' => 'f', 'customers.name c' => 'c' },
        :ajData => @bills,
      }}
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.xml
  def create
    @bill.franchise = current_user.franchises[0]

    respond_to do |format|
      if @bill.save
        flash[:notice] = 'Bill was successfully created.'
        format.html { redirect_to(@bill) }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.xml
  def update
    @bill.modified_by = current_user

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        flash[:notice] = 'Bill was successfully updated.'
        format.html { redirect_to(@bill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.xml
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end
end
