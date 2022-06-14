class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_NF
  rescue_from ActiveRecord::RecordInvalid, with: :error_UE

  # GET /apartments
  def index
    render json: Apartment.all, status: :ok
  end

  # GET /apartment/:id
  def show
    render json: find_apartment, status: :ok
  end

  # POST /apartments
  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  # PATCH /apartments/:id
  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment, status: :accepted
  end

  # DELETE /apartments/:id
  def destroy
    find_apartment.destroy
    head :no_content
  end

  private

  #----------------------   ERRORS   ----------------------#
  def error_NF
    render json: { error: 'Apartment not found' }, status: :not_found
  end

  def error_UE(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  #---------------------- CODE DRYER -----------------------#
  def find_apartment
    Apartment.find(params[:id])
  end

  #----------------------    PARAMS    ----------------------#
  def apartment_params
    params.permit(:number)
  end
end
