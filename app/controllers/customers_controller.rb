class CustomersController < ApplicationController
  before_filter :get_user

  # GET /users/1/customers
  # GET /users/1/customers.json
  def index
    @customers = @user.customers.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /users/1/customers/1
  # GET /users/1/customers/1.json
  def show
    @customer = @user.customers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /user/1/customers/new
  # GET /user/1/customers/new.json
  def new
    @customer = @user.customers.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /users/1/customers/1/edit
  def edit
    @customer = @user.customers.find(params[:id])
  end

  # POST /users/1/customers
  # POST /users/1/customers.json
  def create
    @customer = @user.customers.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/customers/1
  # PUT /users/1/customers/1.json
  def update
    @customer = @user.customers.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/customers/1
  # DELETE /users/1/customers/1.json
  def destroy
    @customer = @user.customers.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to user_customers_url(@user) }
      format.json { head :no_content }
    end
  end

private

  def get_user
    @user = current_user
  end
end
