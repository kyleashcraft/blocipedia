class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    @wiki.private ||= false

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again."
      render :new
    end
  end

  def edit
    @Wiki = Wiki.find(params[:id])
  end

  def update
    @Wiki = Wiki.find(params[:id])
    @Wiki.assign_attributes(wiki_params)

    if @Wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @Wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again."
      render :edit
    end

  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki successfully deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "Error deleting wiki, please try again."
    end
  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end

    def authorize_user
      unless current_user
        flash[:alert] = "You must be signed in to do that."
        redirect_to root_path;
      end
    end

end
