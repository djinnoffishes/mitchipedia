class CollaboratorsController < ApplicationController
  before_filter :store_requested_path

  def make_editor
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:collaborator_id])

    if @collaborator.update_attribute(:access_level, 2)
      flash[:notice] = "Collaborator access level changed."
      redirect_to manage_wiki_path(@wiki)
    else
      flash[:error] = "There was an error changing the access. Try again."
      redirect_to manage_wiki_path(@wiki)
    end
  end

  def make_viewer
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:collaborator_id])

    if @collaborator.update_attribute(:access_level, 1)
      flash[:notice] = "Collaborator access level changed."
      redirect_to manage_wiki_path(@wiki)
    else
      flash[:error] = "There was an error changing the access. Try again."
      redirect_to manage_wiki_path(@wiki)
    end
  end

  def create
    user = User.find_by_email(params[:collaborator][:email])

    @wiki = Wiki.find(params[:wiki_id])
    
    if user.nil?
      flash[:error] = "Email address #{params[:email]} not found!"
      return redirect_to manage_wiki_path(@wiki)
    end

    @collaborator = @wiki.collaborators.build user: user

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    if @collaborator.save
      @collaborator.update_attribute(:access_level, 1)
      flash[:notice] = "Collaborator added."
      redirect_to manage_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator could not be added."
      redirect_to manage_wiki_path(@wiki)
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    @collaborator.update_attribute(:access_level, 0)

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed."
      redirect_to manage_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator couldn't be removed. Try again."
      redirect_to manage_wiki_path(@wiki)
    end
  end

  private

  def store_requested_path
    session[:requested_path] = request.path
  end

end