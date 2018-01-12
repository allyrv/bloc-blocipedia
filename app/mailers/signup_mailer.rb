class SignupMailer < ApplicationMailer
	default from: "atestingemailemail@gmail.com"

	def signup_email(user)
    	@user = user
    	mail(to: @user.email, subject: "Welcome to Blocipedia!")
  	end
end
