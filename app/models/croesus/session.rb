module Croesus
  class Session < ActiveRecord::Base
    self.table_name = 'sessions'
    
    belongs_to :authenticatable, polymorphic: true
  end
end