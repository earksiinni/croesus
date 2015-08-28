require 'rails_helper'

RSpec.describe Croesus::CreateToken do
  let(:fruit_bat) { FactoryGirl.create(:fruit_bat, :with_local_credential) }
  let(:session) { FactoryGirl.create(:session, authenticatable: fruit_bat) }
  let(:token_exemplar) { JWT.encode({ username: fruit_bat.local_credential.username, secret: session.secret }, nil, 'none') }
  
  context 'when passing in a username and secret' do
    let(:generated_token) { Croesus::CreateToken.call username: fruit_bat.local_credential.username, secret: session.secret }
    
    it 'generates a token' do
      expect(generated_token).to eq token_exemplar
    end
    
    it 'does not update the session token attribute' do
      expect(generated_token).to_not eq session.token
    end
  end
  
  context 'when passing in a session' do
    before do
      Croesus::CreateToken.call session: session
    end
  
    it 'generates a token' do
      expect(session.token).to eq token_exemplar
    end
  end
end