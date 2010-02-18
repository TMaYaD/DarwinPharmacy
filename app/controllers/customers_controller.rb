class CustomersController < ApplicationController
  filter_resource_access

  # GET /customers
  # GET /customers.xml
  def index
    params[:iDisplayLength] ||= 10
    params[:iDisplayStart] ||= 0
    params[:sColumns] ||= '*'
    params[:sSort] ||= 'name'
    conditions = [ 'name LIKE :q
        OR phone LIKE :q
        OR address LIKE :q
    ', { :q => "%#{params[:sSearch]}%" } ]

    @customers = Customer.all(
        :select => params[:sColumns],
        :limit => params[:iDisplayLength],
        :offset => params[:iDisplayStart],
        :order => params[:sSort],
        :conditions => conditions
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
      format.js { render :json => {
        :sEcho => params[:sEcho],
        :iTotalRecords => Customer.count,
        :iTotalDisplayRecords => Customer.count(:conditions => conditions),
        :ajData => @customers,
      }}
     end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.xml
  def create
    respond_to do |format|
      if @customer.save
        flash[:notice] = 'Customer was successfully created.'
        format.html { redirect_to(@customer) }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = 'Customer was successfully updated.'
        format.html { redirect_to(@customer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end
end
