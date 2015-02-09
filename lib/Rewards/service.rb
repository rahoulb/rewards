require_relative './invalid_account_number'

module Rewards
  # This service uses an Eligibility Service to check if the given account number is eligible for some rewards
  # It is expected that the eligibility service responds to:
  #     check_eligibility_for(account_number) 
  # returning an array of channels for which the account can claim rewards on.
  # It may raise an InvalidAccountNumber exception if the eligibility service reports the account number back as invalid
  # Otherwise it should always return an array of rewards
  class Service < Struct.new(:eligibility_service)

    def rewards_for account_number: nil, subscriptions: []
      eligibility = eligibility_service.check_eligibility_for(account_number: account_number)
      return [] if eligibility == :ineligible

    rescue InvalidAccountNumber => ian
      raise ian
    rescue Exception
      return []
    end

  end
end
