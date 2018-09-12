class RenameBlogsToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_table :blogs, :posts
    # TODO FL a következő három migráció is mehetett volna ebbe a fájlba - a lényeg, hogy logikusan odatartozhasson, és azok is a "post"-ra való átnevezés lépései
  end
end
