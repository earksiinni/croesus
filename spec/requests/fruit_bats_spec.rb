require 'rails_helper'

describe '/fruit_bats' do
  context 'POST /fruit_bats' do
    let(:username)  { 'ersin@twomaestros.com' }
    let(:password)  { 'abcdefg' }
    let(:fangs)     { 'medium' }
    let(:fruit_bat) { FruitBat.last }
    
    before do
      do_post 
    end
    
    it 'creates a user' do
      expect(FruitBat.count).to eq 1
    end
    
    it 'responds with a fruit bat' do
      expect(json['fruit_bat']['fangs']).to eq fangs
    end
    
    it 'responds with a local credential' do
      expect(json['local_credential']['username']).to eq username
    end
    
    it 'responds with a session' do
      expect(json['session']['token']).to eq JWT.encode({ username: username, secret: fruit_bat.sessions.last.secret }, nil, 'none')
    end
    
    it 'responds with a nonce in the header' do
      expect(response.headers['Authorization']).to eq "Token nonce=#{fruit_bat.sessions.last.nonce}"
    end
  end
  
  def do_post
    post(
      fruit_bats_path,
      { username: username, password: password, password_confirmation: password, fangs: fangs }.to_json,
      { 'Content-Type' => 'application/json' }
    )
  end
end