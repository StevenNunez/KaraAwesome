class AddReputationToSong < ActiveRecord::Migration
  def change
    add_column :songs, :reputation, :integer, default: 0
  end
end
