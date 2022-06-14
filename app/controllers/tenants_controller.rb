class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_NF
  rescue_from ActiveRecord::RecordInvalid, with: :error_UE

  # GET /tenants
  def index
    render json: Tenant.all, status: :ok
  end

  # GET /tenant/:id
  def show
    render json: find_tenant, status: :ok
  end

  # POST /tenants
  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  # PATCH /tenants/:id
  def update
    tenant = find_tenant
    tenant.update!(tenant_params)
    render json: tenant, status: :accepted
  end

  # DELETE /tenants/:id
  def destroy
    find_tenant.destroy
    head :no_content
  end

  private

  #----------------------   ERRORS   ----------------------#
  def error_NF
    render json: { error: 'Tenant not found' }, status: :not_found
  end

  def error_UE(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  #---------------------- CODE DRYER -----------------------#
  def find_tenant
    Tenant.find(params[:id])
  end

  #----------------------    PARAMS    ----------------------#
  def tenant_params
    params.permit(:name, :age)
  end
end
