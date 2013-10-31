class CollaboratorsController < ApplicationController

  def edit
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators

    user_id = User.find_by_email(params[:collaborator][:email]).id
    @collaborator = @wiki.collaborators.build(user_id: user_id)

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to wikis_path
    else
      flash[:error] = "There was an issue adding the collaborator."
      redirect_to wikis_path
    end
  end

  def destroy
  end

  private

  # def collab_params
  #   params.require(:collaborator).permit(:id, :user_id, :wiki_id, :email)
  # end

end