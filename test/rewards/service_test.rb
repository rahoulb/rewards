require 'minitest/autorun'
require 'mocha/setup'
require_relative '../../lib/rewards/service'

describe Rewards::Service do
  subject { Rewards::Service.new eligibility_service }
  let(:eligibility_service) { stub 'Eligibility Service client' }
  let(:account_number) { 'ABC123456' }
  let(:subscriptions) { [:sports, :kids, :music, :news, :movies] }

  describe "when the customer is eligible for rewards" do

  end

  describe "when the customer is not eligible for rewards" do

  end

  describe "when there is a technical failure" do
    before do
      eligibility_service.expects(:check_eligibility_for).with(account_number: account_number).raises(Exception)
    end

    it "returns no rewards to the caller" do
      subject.rewards_for(account_number: account_number, subscriptions: subscriptions).must_equal []
    end
  end

  describe "when the customer account number is invalid" do

  end
end