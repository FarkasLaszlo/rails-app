class LanguagesController < ApplicationController

  def update
    cookies.permanent[:language] = { value: params[:language] } # TODO FL I18n.locale + esetleg a user-en tárolni
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

end

