require 'rails_helper'

RSpec.describe PlaylistsController, :type => :controller do
  xit "Creates a new playlist with a song" do
    patch 'update'
    playlist = assigns(:playlist)
    expect(playlist.songs).to include(song)
  end
end
