class ChargesController < ApplicationController

  def new
    if current_user.premium? || current_user.admin?
      redirect_to edit_user_registration_path(current_user)
    end

    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: amount
    }
    end
  
  def create
    # Creates a Stripe Customer object, for associating with the charge

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note, this is not the user ID in your app
      amount: amount,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

      current_user.update_attribute(:role, "premium")


      flash[:notice] = "Thanks for choosing a Premium membership, #{current_user.email}!"
      redirect_to root_path

      # Stripe sends CardErrors back when something goes wrong, this 'rescue block' catches and displays
      # the errors

      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path
    end

  def destroy
    current_user.update_attribute(:role, "member")
    current_user.wikis.each { |wiki| wiki.update_attribute(:private, false) }
    flash[:notice] = "You have cancelled you premium membership and can only enjoy the benefits of a member user."
    redirect_to edit_user_registration_path(current_user)
  end


  private

  def amount
    15_00
  end
end

