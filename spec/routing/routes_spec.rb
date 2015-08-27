require 'rails_helper'

describe 'routes' do
  specify 'routes' do
    expect(post('/fruit_bats')).to route_to('croesus/authenticatables#create')
  end
end