require 'test_helper'
require 'proxy_object'

describe ProxyObject do
  let(:other) { [1, 2, 3] }
  let(:proxy) { klass.new(other, 'stuff') }

  let(:klass) do
    Class.new {
      include ProxyObject.new(:other)

      def initialize(other, extra, &block)
        super(other)
      end
    }
  end

  it 'adds reader method for target object' do
    assert_equal other, proxy.other
  end

  it 'forwards method calls to target that return other objects' do
    assert_equal 3, proxy.size
  end

  it 'forwads method calls to target that return equal object' do
    assert_equal proxy, proxy.concat([])
  end

  it 'forwdas method calls to target that return new instance of target object' do
    assert_equal klass.new([1, 2, 3, 4], 'stuff').other, proxy.concat([4]).other
  end

  it 'responds to methods defined on the target object' do
    assert proxy.respond_to?(:concat)
  end
end
