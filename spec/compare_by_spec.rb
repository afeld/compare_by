require 'spec_helper'
require 'set'

describe CompareBy do
  it "has a version number" do
    expect(CompareBy::VERSION).not_to be nil
  end

  describe "comparing by no attributes" do
    class TestCompareByZero
      include CompareBy

      attr_accessor :some_attr
    end

    it "doesn't make two instances ==" do
      instance1 = TestCompareByZero.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByZero.new
      instance2.some_attr = 'foo'

      expect(instance1 == instance2).to eq(false)
    end

    it "doesn't make two instances #eql?" do
      instance1 = TestCompareByZero.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByZero.new
      instance2.some_attr = 'foo'

      expect(instance1.eql?(instance2)).to eq(false)
    end

    it "is not unique in a Set" do
      instance1 = TestCompareByZero.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByZero.new
      instance2.some_attr = 'foo'

      set = [instance1, instance2].to_set
      expect(set.size).to eq(2)
    end
  end

  describe "comparing by a single attribute" do
    class TestCompareByOne
      include CompareBy

      attr_accessor :some_attr
      compare_by :some_attr
    end

    it "makes two instances ==" do
      instance1 = TestCompareByOne.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByOne.new
      instance2.some_attr = 'foo'

      expect(instance1 == instance2).to eq(true)
    end

    it "makes two instances #eql?" do
      instance1 = TestCompareByOne.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByOne.new
      instance2.some_attr = 'foo'

      expect(instance1.eql?(instance2)).to eq(true)
    end

    it "is unique in a Set" do
      instance1 = TestCompareByOne.new
      instance1.some_attr = 'foo'
      instance2 = TestCompareByOne.new
      instance2.some_attr = 'foo'

      set = [instance1, instance2].to_set
      expect(set.size).to eq(1)
    end
  end
end
