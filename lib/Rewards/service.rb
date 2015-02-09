require_relative './invalid_account_number'

module Rewards
  class Service < Struct.new(:eligibility_service)

    def rewards_for account_number: nil, subscriptions: []
      eligible_channels = eligibility_service.check_eligibility_for(account_number: account_number)

    rescue InvalidAccountNumber => ian
      raise ian
    rescue Exception
      return []
    end

  end
end
