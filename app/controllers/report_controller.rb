class ReportController < ApplicationController
  filter_access_to :all

  def sales_tax
    params[:search] ||= {}
    params[:search][:created_at_greater_than] ||= Date.today-1.month
    params[:search][:created_at_less_than] ||= Date.today
    @search = SaleBill.search(params[:search])
    @sale_bills = @search.all

    @sales_tax = SaleBill.tax(@sale_bills)
  end

  def retail_sales
    params[:search] ||= {}
    params[:search][:created_at_greater_than] ||= Date.today-1
    params[:search][:created_at_less_than] ||= Date.today
    @search = Bill.with_permissions_to(:show).search(params[:search])
    @bills = @search.all
  end

end
