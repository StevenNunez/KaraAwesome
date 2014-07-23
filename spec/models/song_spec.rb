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

    songs = Song.from_remote('bogus', remote_source)
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

    expect(Song.from_remote('bogus', remote_source)).to be_nil
  end

  it "finds songs if they are already persisted" do
    rs = RemoteSong.new("A Title", "http://example.com", ['t1', 't2'], "Embedded", "123")
    remote_source = RemoteSource.new([rs])

    songs = Song.from_remote('bogus', remote_source)
    expect{Song.from_remote('bogus', remote_source)}.to_not change{Song.count}
    expect(Song.from_remote('bogus', remote_source).first.id).to eq(songs.first.id)
  end
end
