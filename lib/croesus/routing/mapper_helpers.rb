module Croesus
  module Routing
    module MapperHelpers
      def croesus_for(resource)
        resource     = resource.to_sym
        plural       = resource.to_s.pluralize
        create_path = "/#{resource}"
        sessions_path = "/#{resource}/:id/sessions"
        mapping = Croesus.config.create_mapping resource: resource, create_path: create_path, sessions_path: sessions_path
        
        post create_path => 'croesus/authenticatables#create', as: "#{plural}"
        post sessions_path => 'croesus/sessions#create', as: "#{plural}_sessions"
        
        Object.const_set("LocalCredential", Class.new(ActiveRecord::Base) {          
          belongs_to :authenticatable, polymorphic: true
        })
      end
    end
  end
end