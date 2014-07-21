class Selection < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song
  default_scope  { order(position: :asc)}
end
