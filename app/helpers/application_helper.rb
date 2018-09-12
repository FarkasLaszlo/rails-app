module ApplicationHelper
  def creation_time_of object
    l(object.created_at, format: '%Y %B %d %H:%M:%S', locale: (cookies.permanent[:language] || "en")) # TODO SZM default format
  end

  def translate_text text
    t(text, locale: cookies.permanent[:language] || "en", default: text) # TODO FL az I18n tudja önmagában (a Thread.current-ben) tárolni a választott nyelvet, valamint van saját default-ja
  end
end
