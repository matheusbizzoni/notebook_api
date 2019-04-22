class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  
  belongs_to :kind
  has_many :phones
  has_one :address

  def attributes(*args)
    h = super(*args)
    # PT-BR h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = (object.birthdate.to_time.iso8601 unless object.birthdate.blank?)
    return h
  end

  meta do 
    {author: "Matheus"}
  end
end
