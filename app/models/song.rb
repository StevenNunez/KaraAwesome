class Song < ActiveRecord::Base
  has_many :playlists

  def self.from_remote(songs)
    return nil unless songs
    songs.map do |song|
      attrs = {uid: song.uid}
      Song.where(attrs).first_or_create(song.attributes)
    end
  end
end
