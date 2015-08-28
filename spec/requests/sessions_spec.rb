require 'rails_helper'

RSpec.describe '/fruit_bats/:id/sessions' do
  context 'POST /fruit_bats/:id/sessions' do
    let(:fruit_bat) { FactoryGirl.create(:fruit_bat, :with_local_credential) }
    let(:session)   { Croesus::Session.last }
    
    before do
      do_post
    end
    
    it 'creates a session' do
      expect(Croesus::Session.count).to eq 1
    end
    
    specify 'the created session is associated with the authenticatable model' do
      expect(fruit_bat.sessions.last).to eq session
    end
    
    it 'responds with a session' do
      expect(json['session']['token']).to eq session.token
    end
    
    it 'responds with a nonce in the header' do
      expect(response.headers['Authorization']).to eq "Token nonce=\"#{session.nonce}\""
    end
  end
  
  def do_post
    post(
      fruit_bats_sessions_path(fruit_bat_id: fruit_bat.id),
      { username: fruit_bat.local_credential.username, password: 'abcdefg', password_confirmation: 'abcdefg' }.to_json,
      { 'Content-Type' => 'application/json' }
    )
  end
end