require 'compare_by/version'

module CompareBy
  def self.included base
    base.class_variable_set(:@@comparison_attrs, nil)
    base.send :include, Comparable
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def <=>(other)
      attrs = self.class.class_variable_get(:@@comparison_attrs)
      if attrs
        vals = attrs.map { |attr_name| send(attr_name) }
        other_vals = attrs.map { |attr_name| other.send(attr_name) }

        vals <=> other_vals
      else
        super
      end
    end

    def eql?(other)
      self == other
    end

    def hash
      attrs = self.class.class_variable_get(:@@comparison_attrs)
      if attrs
        attrs.map do |attr_name|
          send(attr_name)
        end.hash
      else
        super
      end
    end
  end

  module ClassMethods
    def compare_by(*attr_names)
      class_variable_set(:@@comparison_attrs, attr_names)
    end
  end
end
