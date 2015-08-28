module Croesus
  class CreateSession
    def self.call(params = {})
      new(params[:params]).create_session
    end
    
    def initialize(params)
      local_credential = LocalCredential.where(username: params[:username]).first
      @authenticatable = local_credential.authenticatable
    end
    
    def create_session
      generate_nonce
      generate_secret
      generate_expires_at
      generate_token
      save_session
    end
    
    private
    
    attr_reader :authenticatable, :nonce, :secret, :expires_at, :token
    
    def generate_nonce
      @nonce = SecureRandom.base64(16)
    end
    
    def generate_secret
      @secret = SecureRandom.base64(32)
    end
    
    def generate_expires_at
      @expires_at = 5.years.from_now
    end
    
    def generate_token
      @token = CreateToken.call username: authenticatable.local_credential.username, secret: secret
    end
    
    def save_session
      Session.create(authenticatable: authenticatable, nonce: nonce, secret: secret, expires_at: expires_at, token: token)
    end
  end
end