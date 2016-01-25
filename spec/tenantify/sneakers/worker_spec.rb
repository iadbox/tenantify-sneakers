require 'tenantify/sneakers/worker'

RSpec.describe Tenantify::Sneakers::Worker do

  let(:target) { double 'target' }

  let :test_class do
    Class.new do
      prepend Tenantify::Sneakers::Worker

      def initialize target
        @target = target
      end

      def work msg
        @target.tenant(Tenantify.current)
        :ack
      end
    end
  end

  subject { test_class.new target }

  let(:message)       { "the message" }
  let(:delivery_info) { double 'delivery_info' }
  let(:metadata)      { double 'metadata', :headers => {:tenant => "the_tenant"} }

  describe '#work' do
    it 'properly sets the tenant' do
      expect(target).to receive(:tenant).
        with("the_tenant")

      subject.work_with_params(message, delivery_info, metadata)
    end
  end

end
