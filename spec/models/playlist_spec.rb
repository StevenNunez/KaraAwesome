require 'rails_helper'

RSpec.describe Playlist, :type => :model do
  it "keeps track of songs position when added" do
    playlist = Playlist.create(name: "A playlist")
    song = Song.new(title: "A song")
    playlist.add_song(song)
    expect(playlist.selections.count).to eq(1)
    expect(playlist.selections.last.position).to eq(1)

    another_song = Song.new(title: "Another song")
    playlist.add_song(song)
    expect(playlist.selections.count).to eq(2)
    expect(playlist.selections.last.position).to eq(2)
  end
end
