class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many :phones
    has_one :address
    
    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true

    def author
        "Matheus Bizzoni"
    end

    def as_json(options={})
        h = super(
            root: true,
            only: [:name,:email, :birthdate],
            include: [:kind, :phones],
            methods: [:author]
        )
        h["contact"]["birthdate"] = I18n.l(self.birthdate) unless self.birthdate.blank?
        return h
    end
end
