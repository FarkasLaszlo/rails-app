class ApplicationController < ActionController::Base
  layout "application"
  include SessionsHelper

  before_action :set_locale

  def set_locale
    I18n.locale = cookies[:language] || I18n.default_locale
  end

end
