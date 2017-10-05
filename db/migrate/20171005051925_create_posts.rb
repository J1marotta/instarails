class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :description
      t.text_id :user_id, foreign_key: true
      t.timestamps
    end
  end
end
