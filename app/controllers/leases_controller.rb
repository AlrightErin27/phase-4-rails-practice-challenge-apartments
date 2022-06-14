class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_NF
  rescue_from ActiveRecord::RecordInvalid, with: :error_UE

  # def index
  #   render json: Lease.all, status: :ok
  # end

  # def show
  #   lease = Lease.find(params[:id])
  #   render json: lease, status: :ok
  # end

  # POST /leases
  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  # DELETE /leases/:id
  def destroy
    find_lease.destroy
    head :no_content
  end

  private

  #----------------------   ERRORS   ----------------------#
  def error_NF
    render json: { error: 'Lease not found' }, status: :not_found
  end

  def error_UE(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  #---------------------- CODE DRYER -----------------------#
  def find_lease
    Lease.find(params[:id])
  end

  #----------------------    PARAMS    ----------------------#
  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end
end
