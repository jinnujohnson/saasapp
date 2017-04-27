class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  has_one :profile
  
  attr_accessor :stripe_card_token
  
# If Pro users passes validations(email, passwords, etc)
# Call Stripe and tell Stripe to create subscription upon charging the customer's card
# Stripe then responds with customer data and save customer token and save the user.

def save_with_subscription
  if valid?
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  end
end

end
