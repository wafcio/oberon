module Oberon
  class Attributes
    def initialize
      @attributes = {}
    end

    def add_many(*attribute_names)
      attribute_names.each do |attribute_name|
        @attributes[attribute_name] = nil
      end
    end

    def add_one(name, &block)
      @attributes[name] = block
    end

    def prepare(resource)
      @attributes.each_with_object({}) do |(attribute_name, value), hash|
        hash[attribute_name] =
          if value
            value.call(resource)
          else
            resource.object.send(attribute_name)
          end
      end
    end
  end
end
