require 'rails_helper'

describe Croesus::CreateAuthenticatable do
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
  let(:authenticatable) { FruitBat.last }
  
  before do
    allow(SecureRandom).to receive(:base64) { salt }
    Croesus::CreateAuthenticatable.call(request: request, params: params)
  end
  
  it 'creates an authenticatable' do
    expect(authenticatable.class.count).to eq 1
    expect(authenticatable.local_credential.username).to eq username
    expect(authenticatable.local_credential.encrypted_password).to eq(
      Digest::SHA256.base64digest(Digest::SHA256.base64digest(password) + salt)
    )
    expect(authenticatable.local_credential.salt).to eq salt
    expect(authenticatable.fangs).to eq fangs
  end
end