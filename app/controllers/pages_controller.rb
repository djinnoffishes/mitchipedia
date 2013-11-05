class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
    @page.wiki = @wiki
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, @wiki
    add_breadcrumb "New", :new_wiki_page_path
  end

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @pages = @wiki.pages.paginate(page: params[:page], per_page: 7)

    add_breadcrumb "My wix", :wikis_path
    add_breadcrumb @wiki.title, @wiki
    add_breadcrumb "Pages", :wiki_pages_path
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new(page_params)
    @page.wiki = @wiki

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
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :id, :wiki_id)
  end

end