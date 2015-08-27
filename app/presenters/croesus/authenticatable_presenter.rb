module Croesus
  class AuthenticatablePresenter    
    def initialize(authenticatable)
      @authenticatable = authenticatable
    end
    
    def to_json(options)
      klass = authenticatable.class.name.underscore.to_sym
      "{\"#{klass}\":#{authenticatable.to_json},\"local_credential\":#{authenticatable.local_credential.to_json(only: [:username])}}"
    end
    
    private
    
    attr_reader :authenticatable
  end
end