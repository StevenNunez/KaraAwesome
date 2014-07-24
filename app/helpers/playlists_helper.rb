module PlaylistsHelper
  def element_for_selection(selection, index)
    song = selection.song
    link_to "?selection_id=#{selection.id}", class: 'song-title' do
      content_tag(:div) do
        image_tag(song.thumbnails.first, class: 'img-responsive')
      end +
      "#{index}. #{selection.song.title}" +
      content_tag(:div) do
        link_to "Remove from Playlist", selection, remote: true, method: :delete, class: 'remove-from-playlist'
      end
    end.html_safe
  end
end
