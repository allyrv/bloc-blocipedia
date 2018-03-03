class ApplicationController < ActionController::Base
  include Pundit 
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private 
  	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || root_path)
  	end

end
