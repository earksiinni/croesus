module Croesus
  class AuthenticatablesController < ApplicationController
    wrap_parameters :authenticatable
    
    def create
      authenticatable = CreateAuthenticatable.call request: request, params: params
      if authenticatable
        render json: AuthenticatablePresenter.new(authenticatable)
      else
        head :not_found
      end
    end
  end
end