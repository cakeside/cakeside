class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations, id: :uuid do |t|
      t.uuid :locatable_id
      t.string :locatable_type
      t.string :latitude
      t.string :longitude
      t.string :city
      t.string :country
      t.timestamps
    end
  end
end
