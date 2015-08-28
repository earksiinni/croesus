module Croesus
  module Routing
    module MapperHelpers
      def croesus_for(resource)
        resource              = resource.to_sym
        singular              = resource.to_s.singularize
        authenticatables_path = "/#{resource}"
        sessions_path         = "/#{resource}/:#{singular}_id/sessions"
        mapping = Croesus.config.create_mapping(
          resource: resource, authenticatables_path: authenticatables_path, sessions_path: sessions_path
        )
        
        post authenticatables_path => 'croesus/authenticatables#create', as: "#{resource.to_s}"
        post sessions_path => 'croesus/sessions#create', as: "#{resource.to_s}_sessions"
        
        Object.const_set("LocalCredential", Class.new(ActiveRecord::Base) {          
          belongs_to :authenticatable, polymorphic: true
        })
      end
    end
  end
end