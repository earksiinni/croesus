module Croesus
  class SessionsController < ApplicationController
    wrap_parameters Session
    
    def create
      @session = CreateSession.call params: params
      response.headers['Authorization'] = "Token nonce=\"#{@session.nonce}\""
    end
  end
end