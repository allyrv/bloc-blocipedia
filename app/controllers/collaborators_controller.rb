class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @users = User.all
    current_collabs = @wiki.users

    if @users.include?(@user)
      if current_collabs.include?(@user) || @user == current_user
        flash[:notice] = "#{@user.email} is already a wiki collaborator."
      else

      @collaborator = @wiki.collaborates.new(wiki_id: @wiki.id, user_id: @user.id)
        if @collaborator.save
          flash[:notice] = "#{@user.email} successfully added to wiki."
        else
          flash[:error] = "There was a problem adding the user. Please try again."
        end
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborate.find(params[:id])

    if @collaborator.destroy
       flash[:notice] = "Collaborator has been removed from the wiki collaboration."
    else
      flash[:error] = "There was an error removing the user. Please try again."
    end
    redirect_to @wiki
  end
end