module Croesus
  class Configuration
    include Singleton
    include ::Virtus.model
    
    attribute :mappings, Array[Mapping]
    
    def initialize
      self.mappings = []
    end
    
    def create_mapping(params)
      Mapping.new(params).tap { |m| mappings << m }
    end
    
    def find_mapping_for_authenticatables_path(path)
      selected_mappings = mappings.select { |mapping| mapping.authenticatables_path == path }
      
      raise StandardError, \
        "More than one Croesus resource was found for the path POST #{path}: " \
        "#{selected_mappings.collect { |m| m.resource }}. Please check your routes file." \
        if selected_mappings.count > 1
      selected_mappings.last
    end
  end
end