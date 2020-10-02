require "dry/inflector"

require "oberon/attributes"
require "oberon/relationships"
require "oberon/resource"
require "oberon/version"

module Oberon
  class Error < StandardError; end

  def self.attributes(klass)
    @@attributes ||= {}
    @@attributes[klass] ||= Attributes.new
  end

  def self.relationships(klass)
    @@relationships ||= {}
    @@relationships[klass] ||= Relationships.new
  end
end
