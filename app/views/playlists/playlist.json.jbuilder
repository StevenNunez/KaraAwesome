json.id @playlist.id
json.name @playlist.name
json.selections do
  json.array! @playlist.selections, :position, :song
end
