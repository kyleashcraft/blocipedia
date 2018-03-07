require 'redcarpet'

class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  include Pundit

  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    authorize @wiki

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
    authorize @Wiki
  end

  def update
    @Wiki = Wiki.find(params[:id])
    @Wiki.assign_attributes(wiki_params)

    authorize @Wiki

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

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki successfully deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "Error deleting wiki, please try again."
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized


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

    def not_authorized
      flash[:alert] = "You are not authorized to do that"
      redirect_to wikis_path
    end

end
