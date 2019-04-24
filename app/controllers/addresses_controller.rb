class AddressesController < ApplicationController
  before_action :get_address, except: :create
  # GET /contacts/1/address
  def show
    render json: @address
  end

  # POST /contacts/1/address
  def create
    @contact = Contact.find(params[:contact_id])
    @contact.address =  Address.new(address_params)

    if @contact.address.save
      render json: @contact.address, status: :created, location: contact_address_url(@contact.id)
    else
      render json: @contact.address.errors, status: :unprocessable_entity
    end
  end

  #DELETE /contacts/:contact_is/address
  def destroy
    @address.destroy
  end

  # PATCH /contacts/1/address
  def update
    if @address.update(address_params)
      render json: @address
    else
      renser json: @address.errors, status: :unprocessable_entity
    end
  end

  private 

  def get_address
    @address = Contact.find(params[:contact_id]).address
  end

  def address_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
