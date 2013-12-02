# This controls a nested resource, because every Invoice belongs to a Customer.
# Only its customer can see an invoice.
class InvoicesController < ApplicationController
  load_and_authorize_resource :customer
  load_and_authorize_resource :invoice, through: :customer # https://github.com/ryanb/cancan/wiki/Nested-Resources

  # GET /invoices
  # GET /invoices.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    respond_to do |format|
      if @invoices.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update_attributes(params[:customer])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to customer_invoices_url(@customer) }
      format.json { head :no_content }
    end
  end
end
