class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.text :image_data
      t.references :user_id, foreign_key: true
      t.string :caption

      t.timestamps
    end
  end
end
