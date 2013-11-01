class CollaboratorsController < ApplicationController
  before_filter :store_requested_path

  def edit
  end

  def create
    user = User.find_by_email(params[:collaborator][:email])
    
    if user.nil?
      flash[:error] = "Email address #{params[:email]} not found!"
      return redirect_to wikis_path
    end

    @wiki = Wiki.find(params[:wiki_id])

    @collaborator = @wiki.collaborators.build user: user

    authorize! :manage, @wiki, message: "You must be the wiki owner to do that."

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to wikis_path
    else
      flash[:error] = "Collaborator could not be added."
      redirect_to wikis_path
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed."
      redirect_to wikis_path
    else
      flash[:error] = "Collaborator couldn't be removed. Try again."
      redirect_to wikis_path
    end
  end

  private

  def store_requested_path
    session[:requested_path] = request.path
  end

  # def collab_params
  #   params.require(:collaborator).permit(:id, :user_id, :wiki_id, :email)
  # end

end