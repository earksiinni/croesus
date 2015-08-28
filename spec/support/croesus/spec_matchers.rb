require 'rspec/expectations'

module Croesus
  module SpecMatchers
    extend RSpec::Matchers::DSL
    
    RSpec::Matchers.define :be_base64_encoded do
      match do |actual|
        actual =~ /^([A-Za-z0-9+\/]{4})*([A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)$/
      end
      description do
        "be base64 encoded"
      end
      failure_message do |actual|
        "expected that #{actual} would be base64 encoded"
      end
      failure_message_when_negated do |actual|
        "expected that #{actual} would not be base64 encoded"
      end
    end
  end
end