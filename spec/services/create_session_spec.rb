require 'rails_helper'

RSpec.describe Croesus::CreateSession do
  let(:fruit_bat) { FactoryGirl.create(:fruit_bat, :with_local_credential) }
  let(:local_credential) { fruit_bat.local_credential }
  let(:params) { { username: local_credential.username, password: 'abcdefg', password_confirmation: 'abcdefg' } }
  let(:session) { fruit_bat.sessions.last }
  
  before do
    Croesus::CreateSession.call params: params
  end
  
  it 'creates a session' do
    expect(Croesus::Session.count).to eq 1
  end
  
  specify 'the session secret is a base64 string' do
    expect(session.secret).to be_base64_encoded
  end
  
  specify 'the session nonce is a base64 string' do
    expect(session.nonce).to be_base64_encoded
  end
  
  specify 'the session has an expiration date' do
    expect(session.expires_at).to be_a Time
  end
end