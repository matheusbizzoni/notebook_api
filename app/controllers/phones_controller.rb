class PhonesController < ApplicationController
  before_action :get_contact
  before_action :get_phone, only: [:update,:destroy]
  # GET /contacts/1/phoes
  def show
    render json: @contact.phones
  end

  #POST /contacts/1/phone
  def create
    @contact.phones << Phone.new(phone_params)
    
    if @contact.save
      render json: @contact.phones, status: :crated, location: contact_phones_url(@contact.id)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH /contacts/1/phone
  def update
    if @phone.update(phone_params)
      render json: @contact.phones
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1/phones
  def destroy
    @phone.destroy
  end
  private 
  
  def get_contact
    @contact = Contact.find(params[:contact_id])
  end

  def get_phone
    @phone = Phone.find(phone_params[:id])
  end

  def phone_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
