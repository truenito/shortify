class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  def index
    # Left Joining URLs with visits and then ordering by count DESC (and limiting to 100) 
    # to achieve top 100 most visited feature.
    @urls = Url.left_joins(:url_visits).group(:id).order('COUNT(url_visits.id) DESC').limit(100)
  end

  def show
  end

  def new
    @url = Url.new
  end

  def edit
  end

  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'URL was successfully created.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'URL was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'U was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect
    if params[:shortened_link]
      url = Url.where(shortened_link: ENV['HOST_URL'] + "/#{params[:shortened_link]}").first
      if url
        UrlVisit.create!(url_id: url.id) if redirect_to url.original_link
      end
    else
      redirect_to root_path
    end
  end

  private
  
  def set_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:original_link, :shortened_link, :title, :description)
  end
end
