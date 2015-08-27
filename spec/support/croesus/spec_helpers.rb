module Croesus
  module SpecHelpers
    def json
      JSON.parse response.body
    end
  end
end