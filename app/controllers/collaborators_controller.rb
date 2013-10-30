class CollaboratorsController < ApplicationController

  def edit
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators
    @collaborator = @collaborators.build(collab_params)

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      render :manage
    else
      flash[:error] = "There was an issue adding the collaborator."
      redirect_to manage_wikis_path
    end
  end

  def destroy
  end

  private

  def collab_params
    params.require(:collaborator).permit(:id, :user_id, :wiki_id)
  end

end