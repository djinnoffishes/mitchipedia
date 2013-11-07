class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
    @page.wiki = @wiki

    # authorize! :read, @wiki, message: "You don't have permission to do that."
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new

    authorize! :create, Wiki, message: "You must be signed in to do that."

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, @wiki
    add_breadcrumb "New", :new_wiki_page_path
  end

  def index
    @wiki = Wiki.find(params[:wiki_id])

    @pages = @wiki.pages.paginate(page: params[:page], per_page: 7)
    
    authorize! :read, @wiki, message: "You don't have permission to do that."

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, @wiki
    add_breadcrumb "Pages", :wiki_pages_path
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new(page_params)
    @page.wiki = @wiki

    authorize! :edit, @wiki, message: "You do not have sufficient privileges to edit this wiki."

    if @page.save
      flash[:notice] = "Page created."
      redirect_to wiki_path(id: params[:wiki_id])
    else
      flash[:error] = "There was an error creating the page. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])

    authorize! :destroy, @wiki, message: "You don't have sufficient privleges to delete that page."

    if @page.destroy
      flash[:notice] = "Page was deleted."
      redirect_to wiki_path(id: params[:wiki_id])
    else
      flash[:error] = "Page couldn't be deleted. Try again."
      redirect_to wiki_path(id: params[:wiki_id])
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :id, :wiki_id)
  end

end