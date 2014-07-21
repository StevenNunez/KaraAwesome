class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :selections
  has_many :songs, through: :selections

  def add_song(song)
    position = self.selections.maximum(:position).to_i + 1
    self.selections.create(position: position, song: song)
  end
end
