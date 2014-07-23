module ApplicationHelper
  def notices
    notice_bar + alert_bar
  end
  
  def alert_for(type)
    content_tag(:p, class: "alert alert-#{type}" ) do
      content_tag(:button, class: 'close', "data-dismiss" => 'alert') do
        content_tag(:span, "&times;".html_safe)
      end +
      yield
    end
  end

  def notice_bar
    if notice
      alert_for(:success) do
        notice
      end
    end.to_s.html_safe
  end

  def alert_bar
    if alert
      alert_for(:danger) do
        alert
      end
    end.to_s.html_safe
  end
end
