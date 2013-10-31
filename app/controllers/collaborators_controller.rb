class CollaboratorsController < ApplicationController

  def edit
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators

    begin
      @collaborator = @wiki.collaborators.build user: User.find_by_email(params[:collaborator][:email])
    rescue ActiveRecord::NotFound
      return collaborator_error!
    end

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to wikis_path
    else
      return collaborator_error!
    end
  end

  def destroy
  end

  private

    def collaborator_error!
      flash[:error] = "There was an issue adding the collaborator."
      redirect_to defined?(@wiki) ? manage_wiki_path(@wiki) : wikis_path
    end

  # def collab_params
  #   params.require(:collaborator).permit(:id, :user_id, :wiki_id, :email)
  # end

end
