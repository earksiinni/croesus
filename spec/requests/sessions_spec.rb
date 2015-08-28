require 'rails_helper'

describe '/fruit_bats/:id/sessions' do
  context 'POST /fruit_bats/:id/sessions' do
    let(:username) { 'dracula@stoker.net' }
    let(:password) { 'countchocula' }
    let(:fangs)    { 'long' }
    let(:salt)     { 'saltysalt' }
    let(:request) {
      request = instance_double "ActionDispatch::Request"
    
      allow(request).to receive(:fullpath) { '/fruit_bats' }
      request
    }
    let(:params) {
      {
        authenticatable: { username: username, password: password, password_confirmation: password, fangs: fangs }
      }
    }
    let(:fruit_bat) { FruitBat.last }
    let(:session)   { Session.last }
    
    before do
      # Create fruit bat
      Croesus::CreateAuthenticatable.call(request: request, params: params)
      # Create session
      do_post
    end
    
    it 'creates a session' do
      expect(Session.count).to eq 1
    end
    
    specify 'the created session is associated with the authenticatable model' do
      expect(fruit_bat.sessions.last).to eq session
    end
    
    it 'responds with a session' do
      expect(json['session']['token']).to eq JWT.encode({ username: username, secret: session.secret }, nil, 'none')
    end
    
    it 'responds with a nonce in the header' do
      expect(response.headers['Authorization']).to eq "Token nonce=#{session.nonce}"
    end
  end
  
  def do_post
    post(
      fruit_bats_sessions_path(fruit_bat_id: fruit_bat.id),
      { username: username, password: password, password_confirmation: password }.to_json,
      { 'Content-Type' => 'application/json' }
    )
  end
end