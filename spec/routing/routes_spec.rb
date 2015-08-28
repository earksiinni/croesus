require 'rails_helper'

RSpec.describe 'routes' do
  specify 'routes' do
    expect(post('/fruit_bats')).to route_to('croesus/authenticatables#create')
    expect(post(fruit_bats_path)).to route_to('croesus/authenticatables#create')
    
    expect(post('/fruit_bats/1/sessions')).to route_to('croesus/sessions#create', fruit_bat_id: '1')
    expect(post(fruit_bats_sessions_path(fruit_bat_id: 1))).to route_to('croesus/sessions#create', fruit_bat_id: '1')
  end
end