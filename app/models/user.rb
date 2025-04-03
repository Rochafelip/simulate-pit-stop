class User < ApplicationRecord
  before_create :set_default_role_and_admin
  enum role: { user: 0, admin: 1 }

        # Devise modules
        devise :database_authenticatable, :registerable,
               :recoverable, :rememberable, :validatable, :confirmable 
        
        # DeviseTokenAuth module
        include DeviseTokenAuth::Concerns::User
        
        # Validações
        validates :name, presence: true
        validates :password_confirmation, presence: true, on: :create
        validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "não é válido" }
        
       # Garante que o `uid` é gerado automaticamente caso não seja fornecido
       before_validation :set_uid, on: :create

       private

       def set_uid
       self.uid = email if uid.blank?
       self.provider = "email" if provider.blank?
       end

       def set_default_role_and_admin
              self.role ||= 0    # Padrão para 'usuário comum'
              self.admin ||= false  # Padrão para 'não admin'
            end

      end
      