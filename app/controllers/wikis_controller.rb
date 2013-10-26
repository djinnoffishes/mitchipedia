class WikisController < ApplicationController
  def index
    # TODO: scope to visible_to current user
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 7)
  end

  def new
    @wiki = Wiki.new
    # authorization - must be able to create wikis
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)

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
    # set an instance variable for all pages visible to the current user
  end

  def edit
    @wiki = Wiki.find(params[:id])
    # authorization - must be able to edit specified wiki
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
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :description, :public, :user_id)
  end
end
