require 'rails_helper'

describe '/fruit_bats' do
  context 'POST /fruit_bats' do
    before do
      do_post 
    end
    
    it 'creates a user' do
      expect(FruitBat.count).to eq 1
    end
    
    it 'responds with a fruit bat' do
      expect(json['fruit_bat']['fangs']).to eq 'medium'
      expect(json['local_credential']['username']).to eq 'ersin@twomaestros.com'
    end
  end
  
  def do_post
    post(
      fruit_bats_path,
      { username: 'ersin@twomaestros.com', password: 'abcdefg', password_confirmation: 'abcdefg', fangs: 'medium' }.to_json,
      { 'Content-Type' => 'application/json' }
    )
  end
end