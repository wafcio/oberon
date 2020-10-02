module Oberon
  class Resource
    attr_reader :object, :inflector

    def self.inherited(subclass)
      extend ClassMethods
    end

    def initialize(object)
      @object = object
      @inflector = Dry::Inflector.new
    end

    def id
      object.id
    end

    def type
      inflector.dasherize(
        inflector.pluralize(
          inflector.underscore(
            self.class.to_s.gsub("Resource", "")
          )
        )
      )
    end

    def attributes
      Oberon.attributes(self.class.to_s).prepare(self)
    end

    def relationships
      Oberon.relationships(self.class.to_s).prepare(self)
    end

    module ClassMethods
      def attributes(*names)
        Oberon.attributes(to_s).add_many(*names)
      end

      def attribute(name, &block)
        Oberon.attributes(to_s).add_one(name, &block)
      end

      def relationships(*names)
        Oberon.relationships(to_s).add_many(*names)
      end

      def relationship(name, &block)
        Oberon.relationships(to_s).add_one(name, &block)
      end
    end
  end
end
