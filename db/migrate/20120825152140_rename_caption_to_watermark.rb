class RenameCaptionToWatermark < ActiveRecord::Migration
  def change
    change_table :creations do |t|
      t.rename :caption, :watermark
    end
  end
end
