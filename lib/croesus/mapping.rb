module Croesus
  class Mapping
    include ::Virtus.model
    
    attribute :resource, String
    attribute :authenticatables_path, String
    attribute :sessions_path, String
    attribute :klass, Class
    
    def initialize(params = {})
      self.resource              = params[:resource]
      self.authenticatables_path = params[:authenticatables_path]
      self.sessions_path         = params[:sessions_path]
      self.klass                 = params[:resource].to_s.singularize.camelize.constantize
    end
  end
end