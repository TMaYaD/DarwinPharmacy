class PurchaseRequestsController < ApplicationController
  filter_resource_access

# GET /purchase_requests
  def index
    @purchase_requests = PurchaseRequest.all
  end

  # GET /purchase_requests/1
  def show
  end

  # GET /purchase_requests/new
  def new
  end

  # GET /purchase_requests/1/edit
  def edit
  end

  # POST /purchase_requests
  def create
    if @purchase_request.save
      flash[:notice] = 'PurchaseRequest was successfully created.'
      redirect_to(@purchase_request)
    else
      render :action => "new"
    end
  end

  # PUT /purchase_requests/1
  def update
    if @purchase_request.update_attributes(params[:purchase_request])
      flash[:notice] = 'PurchaseRequest was successfully updated.'
      redirect_to(@purchase_request)
    else
      render :action => "edit"
    end
  end

  # DELETE /purchase_requests/1
  def destroy
    @purchase_request.destroy

    redirect_to(purchase_requests_url)
  end
end
