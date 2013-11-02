class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new(page_params)

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