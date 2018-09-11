module ApplicationHelper
  def creation_time_of object
    l(object.created_at, format: '%Y %B %d %H:%M:%S', locale: (cookies.permanent[:language] || "en"))
  end

  def translate_text text
    t(text, locale: cookies.permanent[:language] || "en", default: text)
  end
end
