require "croesus/engine"
require "virtus"
require "jbuilder"
require "jwt"

module Croesus
  autoload :Mapping, 'croesus/mapping.rb'
  autoload :Configuration, 'croesus/configuration.rb'
  autoload :ModelHelpers, 'croesus/model_helpers.rb'
  
  module Routing
    autoload :MapperHelpers, 'croesus/routing/mapper_helpers.rb'
  end
  
  def self.config
    Configuration.instance
  end
end

require "croesus/routing/mapper_helpers"
require "croesus/mapping"
require "croesus/configuration"
require "croesus/model_helpers"

ActionDispatch::Routing::Mapper.include Croesus::Routing::MapperHelpers
ActiveRecord::Base.extend Croesus::ModelHelpers