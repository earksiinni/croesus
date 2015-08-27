module Croesus
  class Mapping
    include ::Virtus.model
    
    attribute :resource, String
    attribute :create_path, String
    attribute :klass, Class
    
    def initialize(params = {})
      self.resource    = params[:resource]
      self.create_path = params[:create_path]
      self.klass       = params[:resource].to_s.singularize.camelize.constantize
    end
  end
end