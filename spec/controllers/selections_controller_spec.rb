require 'rails_helper'

RSpec.describe SelectionsController, :type => :controller do
  describe '#destroy' do
    it 'allows user to destroy their own selection' do
      michael = User.create(email: "mnunez@example.com", password: "I love cats")
      sign_in michael

      playlist = Playlist.create
      playlist.user = michael
      selection = playlist.selections.create
      expect do
        delete 'destroy', id: selection.id
      end.to change {Selection.count}.by(-1)
    end

    it 'prevents users from deleting other selections' do
      michael = User.create(email: "mnunez@example.com", password: "I love cats")

      steve = User.create(email: "snunez@example.com", password: "I love Dags")
      sign_in michael
      
      playlist = Playlist.create
      playlist.user = steve
      selection = playlist.selections.create

      expect do
        delete 'destroy', id: selection.id
      end.to change {Selection.count}.by(0)
    end
  end
end
