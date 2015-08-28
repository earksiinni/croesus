module Croesus
  class AuthenticatablesController < ApplicationController
    wrap_parameters :authenticatable
    
    def create
      @authenticatable = CreateAuthenticatable.call request: request, params: params
      if @authenticatable
        @authenticatable.sessions.last.update_attributes nonce: SecureRandom.base64(16)
        response.headers['Authorization'] = "Token nonce=\"#{@authenticatable.sessions.last.nonce}\""
      else
        head :not_found
      end
    end
  end
end