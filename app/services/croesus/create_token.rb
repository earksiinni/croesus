module Croesus
  class CreateToken
    def self.call(params = {})
      new(params).create_token
    end
    
    def initialize(params)
      if params[:session]
        @session  = params[:session]
        @secret   = session.secret
        @username = session.authenticatable.local_credential.username
      else
        @secret   = params[:secret]
        @username = params[:username]
      end
    end
    
    def create_token
      generate_token
      save_token_to_session if session
      
      token
    end
    
    private
    
    attr_reader :secret, :username, :token, :session
    
    def generate_token
      @token = JWT.encode({ username: username, secret: secret }, nil, 'none')
    end
    
    def save_token_to_session
      session.update_attributes token: token
    end
  end
end