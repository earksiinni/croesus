module Croesus
  module ModelHelpers
    def croesus
      has_one :local_credential, as: :authenticatable
    end
  end
end