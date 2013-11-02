class WikisController < ApplicationController

  def index
    # TODO: scope to visible_to current user
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 7)
    add_breadcrumb "My wix", :wikis_path
  end

  def new
    @wiki = Wiki.new
  
    authorize! :create, Wiki, message: "You must be signed in to do that."
  end

  def create
    @wiki = current_user.wiki_ownerships.build(wiki_params.merge( owner_id: current_user.id ))

    authorize! :create, Wiki, message: "You must be signed in to do that."

    if @wiki.save
      flash[:notice] = "Wiki created."
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating the wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    
    authorize! :read, Wiki, message: "You don't have permission to do that."

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, :wiki_path
  end

  def edit
    authorize! :edit, Wiki, message: "You do not have sufficient privileges to edit this wiki."

    @wiki = Wiki.find(params[:id])
    
    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, :wiki_path
    add_breadcrumb "Edit", :edit_wiki_path
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize! :update, Wiki, message: "You don't have permission to update this wiki."

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def manage
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    @owner = User.find(@wiki.owner_id)
    
    @collaborator = @collaborators.new

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, :wiki_path
    add_breadcrumb "Management", :manage_wiki_path
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize! :destroy, @wiki, message: "You must be the wiki owner to do that."

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :manage
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :description, :public, :user_id, :owner_id)
  end
end
