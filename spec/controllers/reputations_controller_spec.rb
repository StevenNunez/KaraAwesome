require 'rails_helper'

RSpec.describe ReputationsController, :type => :controller do

  describe "put 'update'" do
    it "increases the reputation of a song" do
      song = Song.create(title: "A new song")
      steve = User.create(email: "snunez@example.com", password: "I love Dags")
      sign_in steve

      put 'update', song_id: song.id
      song.reload
      expect(song.reputation).to eq(1)
    end
  end

end
