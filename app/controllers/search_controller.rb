class SearchController < ApplicationController
  skip_filter :authenticate_user!
  def index
    if params[:q]
      @query = params[:q]
      if signed_in?
        @playlist = current_user.playlists.first_or_create(name: "Now Playing")
      else
        @playlist = OpenStruct.new
      end
      @results = Song.from_remote(params[:q])
      render :show
    end
  end
end
