#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__),'lib')

require 'rspec'
require 'rpn'

describe RPN do
  describe '#parse_symbol' do
    it 'should parse positive numbers' do
      RPN.new().parse_symbol("3").should eq(3)
    end

    it 'should parse 2 digit numbers' do
      RPN.new().parse_symbol("45").should eq(45)
    end

    it 'should parse negative numbers' do
      RPN.new().parse_symbol("-6").should eq(-6)
    end

    it 'should parse plus' do
      RPN.new().parse_symbol("+").should eq(OpPlus)
    end

    it 'should throw exception for invalid number' do
      expect { RPN.new().parse_symbol("a") }.to raise_error(ArgumentError)
    end
  end

  describe '#parse_string' do
    it 'should handle 2 numbers and plus' do
      op = RPN.new("2 3 +").parse
      op.class.should eq(OpPlus)
      op.a.evaluate.should eq(3)
      op.b.evaluate.should eq(2)
      op.evaluate.should eq(5)
    end

    it "should handle divide" do
      RPN.new("4 2 /").parse.evaluate.should eq(2)
    end

    it "should handle multiply" do
      RPN.new("4 2 *").parse.evaluate.should eq(8)
    end

    it "should handle arguments in the correct order (minus)" do
      RPN.new("13 4 -").parse.evaluate.should eq(9)
    end

    it "should handle plus and divide" do
      RPN.new("2 3 4 + *").parse.evaluate.should eq(14)
    end

    it "should handle 2 levels of arguments" do
      RPN.new("3 4 + 5 6 + *").parse.evaluate.should eq(77)
    end

    it 'should throw exception when not enough arguments' do
      expect { RPN.new("2 +").parse }.to raise_error(ArgumentError)
    end
  end
end