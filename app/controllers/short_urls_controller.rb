class ShortUrlsController < ApplicationController
  before_filter :authenticate_user

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.save
      redirect_to short_urls_path
    else
      render 'new'
    end
  end

  def index
    @short_urls = current_user.short_urls
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url,:user_id)
  end
end
