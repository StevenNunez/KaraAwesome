class ReputationsController < ApplicationController
  def update
    @song= Song.find(params[:song_id])
    @song.update(reputation: @song.reputation + 1)
    render nothing: true
  end
end
