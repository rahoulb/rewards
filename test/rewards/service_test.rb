require 'minitest/autorun'
require 'mocha/setup'
require_relative '../../lib/rewards/service'

describe Rewards::Service do
  subject { Rewards::Service.new eligibility_service }
  let(:eligibility_service) { stub 'Eligibility Service client' }
  let(:account_number) { 'ABC123456' }
  let(:subscriptions) { [:sports, :kids, :music, :news, :movies] }

  describe "when the customer is eligible for rewards" do
    let(:lesser_subs) { [:sports, :kids, :music] }

    before do
      eligibility_service.expects(:check_eligibility_for).with(account_number: account_number).returns(:eligible)
    end

    it "returns a reward for each subscription" do
      subject.rewards_for(account_number: account_number, subscriptions: subscriptions).must_equal [:champions_league_final_ticket, :karaoke_pro_microphone, :pirates_of_the_caribbean_collection]
    end

    it "does not return a reward for subscriptions that the user does not have" do
      subject.rewards_for(account_number: account_number, subscriptions: lesser_subs).must_equal [:champions_league_final_ticket, :karaoke_pro_microphone]
    end

  end

  describe "when the customer is not eligible for rewards" do
    before do
      eligibility_service.expects(:check_eligibility_for).with(account_number: account_number).returns(:ineligible)
    end

    it "returns no rewards to the caller" do
      subject.rewards_for(account_number: account_number, subscriptions: subscriptions).must_equal []
    end

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
    before do
      eligibility_service.expects(:check_eligibility_for).with(account_number: account_number).raises(Rewards::InvalidAccountNumber)
    end

    it "returns no rewards to the caller, but does return an error code" do
      -> { subject.rewards_for(account_number: account_number, subscriptions: subscriptions) }.must_raise(Rewards::InvalidAccountNumber)
    end
  end
end
