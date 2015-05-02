class AirconditionersController < ApplicationController
  before_action :set_airconditioner, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:destroy, :edit]

  def search
    if params[:search].present?
      @airconditioners = Airconditioner.search(params[:search])
    else
      @airconditioners = Airconditioner.all
    end
  end

  def autocomplete
    render json: Airconditioner.search(params[:query], fields:[{name: :text_start}], limit: 10).map(&:name)
  end
  

  def index
    @airconditioners = Airconditioner.all
    
  end

  def show
  end

  def new
    @airconditioner = Airconditioner.new
    
  end

  def edit
  end

  def create
 @airconditioner = Airconditioner.new(airconditioner_params)
    respond_to do |format|
      if @airconditioner.save
        format.html { redirect_to  @@airconditioner, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location:  @airconditioner }
      else
        format.html { render :new }
        format.json { render json:  @airconditioner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @airconditioner.update(airconditioner_params)
        format.html { redirect_to @airconditioner, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @airconditioner }
      else
        format.html { render :edit }
        format.json { render json: @airconditioner.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @airconditioner.destroy
    respond_to do |format|
      format.html { redirect_to airconditioner_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_airconditioner
      @airconditioner = Airconditioner.find(params[:id])
    end

    def airconditioner_params
      params.require(:airconditioner).permit(:company_name, :company_description, :address, :city, :zipcode, :contact_name, :company_website, :company_phone, :image)
    end
    def check_user
        unless current_user.admin?
         redirect_to root_url, alert: "Sorry, Only Ontario's Only Admin can Delete a Subscription"
    end
  end
    
end
