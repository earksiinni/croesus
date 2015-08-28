module Croesus
  module ModelHelpers
    def croesus
      has_one :local_credential, as: :authenticatable
      has_many :sessions, as: :authenticatable, class_name: 'Croesus::Session'
    end
  end
end