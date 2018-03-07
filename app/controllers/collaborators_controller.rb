class CollaboratorsController < ApplicationController

  def index
  end
  
  def new
    @collaborator = Collaborator.new
  end

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find_by(email: params[:search])
    
    if user
      collaborator = Collaborator.new(wiki: wiki, user: user)
      authorize collaborator
      if collaborator.save
        flash[:notice] = "Collaborator was saved."
        redirect_to wiki_path(wiki)
      else
        flash.now[:error] = "There was an error saving the Collaborator. Please try again."
      end
    end
  end
  

  def destroy
    collaborator = Collaborator.find(params[:id])
    authorize collaborator
    wiki = collaborator.wiki
    if collaborator.destroy
      flash[:notice] = "Collaborator removed"
      redirect_to wiki
    else
      flash.now[:alert] = "Error"
      render :show
    end
  end
end