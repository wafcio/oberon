module Oberon
  class Relationships
    def initialize
      @relationships = {}
      @inflector = Dry::Inflector.new
    end

    def add_many(*relationship_names)
      relationship_names.each do |relationship_name|
        @relationships[relationship_name] = nil
      end
    end

    def add_one(name, &block)
      @relationships[name] = block
    end

    def prepare(resource)
      @relationships.each_with_object({}) do |(relationship_name, value), hash|
        hash[relationship_name] = {
          mapper: Object.const_get("#{inflector.classify(relationship_name.to_s)}Resource"),
        }
        hash[relationship_name][:data] =
          if value
            value.call(resource)
          else
            resource.object.send(relationship_name)
          end
      end
    end

    private

    attr_reader :inflector
  end
end
