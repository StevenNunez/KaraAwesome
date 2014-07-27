require 'rails_helper'

RSpec.describe Song, :type => :model do
  RemoteSong = Struct.new(:title, :url, :thumbnails, :embed_url, :uid) do
    def attributes
      self.to_h
    end
  end

  RemoteSource = Struct.new(:obj) do
    def search(*)
      obj
    end
  end

  it "adds songs from SongQuery" do
    rs = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "123")
    remote_source = RemoteSource.new([rs])

    songs = Song.from_remote('a query', remote_source)
    expect(songs.count).to eq(1)
    song = songs.first
    expect(song.id).to_not be_nil
    expect(song.title).to eq("A Title")
    expect(song.url).to eq("http://example.com")
    expect(song.thumbnails.count).to eq(2)
    expect(song.embed_url).to eq("Embedded")
    expect(song.uid).to eq("123")
  end

  it "returns nil if no remote songs found" do
    rs = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "123")
    remote_source = RemoteSource.new(nil)

    expect(Song.from_remote('a query', remote_source)).to be_nil
  end

  it "finds songs if they are already persisted" do
    rs = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "123")
    remote_source = RemoteSource.new([rs])

    songs = Song.from_remote('a query', remote_source)
    expect{Song.from_remote('a query', remote_source)}.to_not change{Song.count}
    expect(Song.from_remote('a query', remote_source).first.id).to eq(songs.first.id)
  end

  it "Sorts songs by reputation regardless of query result order" do
    meh_song = Song.create(uid: 'meh_song')
    good_song = Song.create(reputation: 2, uid: 'good_song')
    great_song = Song.create(reputation: 10, uid: 'great_song')

    remote_meh_song = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "meh_song")
    remote_good_song = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "good_song")
    remote_great_song = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "great_song")
    remote_source = RemoteSource.new([good_song, meh_song, great_song])
    songs = Song.from_remote('a query', remote_source)
    expect(songs).to eq([great_song, good_song, meh_song])
  end
end
