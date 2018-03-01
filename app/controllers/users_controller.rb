class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new
		@user.name =                  params[:user][:name]
		@user.email =                 params[:user][:email]
		@user.password =              params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]

		if @user.save
			flash[:notice] = "Welcome to Blocipedia, #{@user.name}!"
			redirect_to root_path
		else
			flash[:error] = "There was an error creating your account. Please try again."
			render :new
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = current_user
	end

	def downgrade
		if current_user.premium?
			current_user.standard!
			flash[:notice] = "You have been downgraded to standard."
			redirect_to root_path
		else
			flash[:error] = "There was an error downgrading your account. Please try again."
			redirect_to edit_user_registration_path
		end
	end
end