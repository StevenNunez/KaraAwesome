class Song < ActiveRecord::Base
  default_scope { order(reputation: :desc) }
  has_many :playlists

  def self.from_remote(query, remote=GimmeKaraoke::SongQuery)
    songs = remote.search(query)
    return nil unless songs
    s = songs.map do |song|
      attrs = {uid: song.uid}
      Song.where(attrs).first_or_create(song.attributes)
    end.sort_by{|s| -s.reputation}
  end
end
