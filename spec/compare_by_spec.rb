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

    let(:instance1) { TestCompareByZero.new }
    let(:instance2) { TestCompareByZero.new }

    before do
      instance1.some_attr = 'foo'
      instance2.some_attr = 'foo'
    end

    it "doesn't make two instances ==" do
      expect(instance1 == instance2).to eq(false)
    end

    it "doesn't make two instances #eql?" do
      expect(instance1.eql?(instance2)).to eq(false)
    end

    it "is not unique in a Set" do
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

    let(:instance1) { TestCompareByOne.new }
    let(:instance2) { TestCompareByOne.new }

    describe "two instances with the same values" do
      before do
        instance1.some_attr = 'foo'
        instance2.some_attr = 'foo'
      end

      it "makes them ==" do
        expect(instance1 == instance2).to eq(true)
      end

      it "makes them #eql?" do
        expect(instance1.eql?(instance2)).to eq(true)
      end

      it "makes them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(1)
      end
    end

    describe "two instances with different values" do
      before do
        instance1.some_attr = 'foo'
        instance2.some_attr = 'bar'
      end

      it "makes them !=" do
        expect(instance1 != instance2).to eq(true)
      end

      it "makes them not #eql?" do
        expect(instance1.eql?(instance2)).to eq(false)
      end

      it "doesn't make them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(2)
      end
    end
  end

  describe "comparing by multiple attributes" do
    class TestCompareByMultiple
      include CompareBy

      attr_accessor :some_attr, :some_other_attr
      compare_by :some_attr, :some_other_attr
    end

    let(:instance1) { TestCompareByMultiple.new }
    let(:instance2) { TestCompareByMultiple.new }

    describe "two instances with the same values" do
      before do
        instance1.some_attr = 'foo'
        instance1.some_other_attr = 'bar'
        instance2.some_attr = 'foo'
        instance2.some_other_attr = 'bar'
      end

      it "makes them ==" do
        expect(instance1 == instance2).to eq(true)
      end

      it "makes them #eql?" do
        expect(instance1.eql?(instance2)).to eq(true)
      end

      it "makes them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(1)
      end
    end

    describe "two instances with only first value matching" do
      before do
        instance1.some_attr = 'foo'
        instance1.some_other_attr = 'bar'
        instance2.some_attr = 'foo'
        instance2.some_other_attr = 'baz'
      end

      it "makes them !=" do
        expect(instance1 != instance2).to eq(true)
      end

      it "makes them not #eql?" do
        expect(instance1.eql?(instance2)).to eq(false)
      end

      it "doesn't make them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(2)
      end
    end

    describe "two instances with only last value matching" do
      before do
        instance1.some_attr = 'foo'
        instance1.some_other_attr = 'bar'
        instance2.some_attr = 'baz'
        instance2.some_other_attr = 'bar'
      end

      it "makes them !=" do
        expect(instance1 != instance2).to eq(true)
      end

      it "makes them not #eql?" do
        expect(instance1.eql?(instance2)).to eq(false)
      end

      it "doesn't make them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(2)
      end
    end

    describe "two instances with no values matching" do
      before do
        instance1.some_attr = 'foo'
        instance1.some_other_attr = 'bar'
        instance2.some_attr = 'baz'
        instance2.some_other_attr = 'blip'
      end

      it "makes them !=" do
        expect(instance1 != instance2).to eq(true)
      end

      it "makes them not #eql?" do
        expect(instance1.eql?(instance2)).to eq(false)
      end

      it "doesn't make them unique in a Set" do
        set = [instance1, instance2].to_set
        expect(set.size).to eq(2)
      end
    end
  end
end
