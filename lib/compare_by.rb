require 'compare_by/version'

module CompareBy
  def self.included base
    base.class_variable_set(:@@compare_by, nil)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def ==(other)
      compare_by = self.class.class_variable_get(:@@compare_by)
      send(compare_by) == other.send(compare_by)
    end

    alias_method :eql?, :==

    def hash
      compare_by = self.class.class_variable_get(:@@compare_by)
      send(compare_by).hash
    end
  end

  module ClassMethods
    def compare_by(attr_name)
      class_variable_set(:@@compare_by, attr_name)
    end
  end
end
