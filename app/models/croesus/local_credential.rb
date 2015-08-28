module Croesus
  class LocalCredential < ActiveRecord::Base
    self.table_name = 'local_credentials'
    
    belongs_to :authenticatable, polymorphic: true
  end
end