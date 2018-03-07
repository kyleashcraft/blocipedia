class ChargesController < ApplicationController
  require 'amount'

  def create
    customer = Stripe::Customer.create( #customer var for charge
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, #not User model id
      amount: Amount.default,
      description: "Blocipedia Premium - #{current_user.email}",
      currency: 'usd'
    )


    flash[:notice] = "Thank you for purchasing premium, #{current_user.email}!"
    current_user.premium!
    redirect_to root_path

  rescue Stripe::CardError => e #display stripe card errors
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium - #{current_user.email}",
      amount: Amount.default
    }
  end

end
