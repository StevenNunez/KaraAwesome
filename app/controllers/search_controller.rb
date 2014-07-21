class SearchController < ApplicationController
  def index
    if params[:q]
      @query = params[:q]
      @results = GimmeKaraoke::SongQuery.search(params[:q])
      render :show
    end
  end
end
