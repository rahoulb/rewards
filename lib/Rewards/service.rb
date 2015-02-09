module Rewards
  class Service < Struct.new(:eligibility_service)

    def rewards_for account_number: nil, subscriptions: []
      eligible_channels = eligibility_service.check_eligibility_for(account_number: account_number)

    rescue Exception
      return []
    end

  end
end
