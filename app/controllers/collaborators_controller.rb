class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:collaborator][:user])
    @collaborator = Collaborator.new(user: @user, wiki: @wiki)
    if @collaborator.save
      flash[:notice] = "#{@user.email} added as a collaborator."
      redirect_back(fallback_location: @wiki)
    else
      if @user
        flash[:alert] = "Failed to add #{@user.email} as a collaborator."
      else
        flash[:alert] = "No account is linked to #{params[:collaborator][:user]}."
      end
      redirect_back(fallback_location: @wiki)
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "#{@collaborator.user.email} is no longer a collaborator for #{@collaborator.wiki.title}."
      redirect_back(fallback_location: @wiki)
    else
      flash[:alert] = "Failed to remove #{@collaborator.user.email}, please try again."
      redirect_back(fallback_location: @wiki)
    end
  end

  private
    def collaborator_params
      params.require(:collaborator).permit(:user_id, :wiki_id)
    end
end
