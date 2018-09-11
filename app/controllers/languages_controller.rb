class LanguagesController < ApplicationController

  def update
    cookies.permanent[:language] = { value: params[:language] }
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

end

