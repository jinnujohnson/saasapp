class Users::RegistrationsController < Devise::RegistrationsController
    
# Extend Devise gem default behaviour so that
# users signingup with pro account[plan id 2]
# save with a special Stripe subscription function
# Otherwise devise signup users with ordinary function

  before_action :select_plan, only: :new
  
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
  
  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end