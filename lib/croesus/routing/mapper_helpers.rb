module Croesus
  module Routing
    module MapperHelpers
      def croesus_for(resource)
        resource     = resource.to_sym
        create_path = "/#{resource}"
        mapping = Croesus.config.create_mapping resource: resource, create_path: create_path
        
        post create_path => 'croesus/authenticatables#create'
        
        Object.const_set("LocalCredential", Class.new(ActiveRecord::Base) {          
          belongs_to :authenticatable, polymorphic: true
        })
      end
    end
  end
end