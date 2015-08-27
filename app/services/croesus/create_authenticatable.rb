module Croesus
  class CreateAuthenticatable
    include Virtus.model
    
    def self.call(params = {})
      new(params).create_authenticatable
    end
    
    def initialize(params)
      mapping                      = Croesus.config.find_mapping_for_create_path params[:request].fullpath
      self.resource                = mapping.resource
      self.klass                   = mapping.klass
      self.local_credential_params = params[:params][:authenticatable].extract!(:username, :password, :password_confirmation).symbolize_keys
      self.model_params            = params[:params][:authenticatable].symbolize_keys
    end
    
    def create_authenticatable
      ActiveRecord::Base.transaction do
        create_class_instance
        create_local_credential
      end
      
      authenticatable
    end
    
    private
    
    attribute :resource, String
    attribute :klass, Class
    attribute :local_credential_params, Hash
    attribute :model_params, Hash
    attr_reader :authenticatable
    
    def create_class_instance
      @authenticatable = klass.create(model_params)
    end
    
    def create_local_credential
      salt = SecureRandom.base64
      encrypted_password = Digest::SHA256.base64digest(Digest::SHA256.base64digest(local_credential_params[:password]) + salt)
      
      LocalCredential.create(
        authenticatable: authenticatable,
        username: local_credential_params[:username],
        encrypted_password: encrypted_password,
        salt: salt
      )
    end
  end
end