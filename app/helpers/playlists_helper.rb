module PlaylistsHelper
  def element_for_selection(selection, index)
    song = selection.song
    link_to "?selection_id=#{selection.id}" do
      content_tag(:div) do
        image_tag(song.thumbnails.first, class: 'img-responsive')
      end +
      "#{index}. #{selection.song.title}"
    end.html_safe
  end
end
