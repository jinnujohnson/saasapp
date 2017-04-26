class Users::RegistrationsController < Devise::RegistrationsController
    
# Extend Devise gem default behaviour so that
# users signingup with pro account[plan id 2]
# save with a special Stripe subscription function
# Otherwise devise signup users with ordinary function

  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end