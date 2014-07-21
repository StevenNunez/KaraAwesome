class SearchController < ApplicationController
  def index
    if params[:q]
      @query = params[:q]
      @playlist = Playlist.first_or_create(name: "Now Playing")
      songs = GimmeKaraoke::SongQuery.search(params[:q])
      @results = Song.from_remote(songs)
      render :show
    end
  end
end
