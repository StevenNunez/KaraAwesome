class PlaylistsController < ApplicationController
  def show
    @playlist = current_user.playlists.find params[:id]
    @current_selection = @playlist.selections.find_by(id: params[:selection_id]) ||
      @playlist.selections.first
    respond_to do |format|
      format.html
      format.json {render 'playlist'}
    end
  end

  def update
    song = Song.find_by uid: params[:song]
    @playlist = current_user.playlists.find params[:id]
    @playlist.add_song song
    respond_to do |format|
      format.json {render 'playlist'}
    end
  end
end
