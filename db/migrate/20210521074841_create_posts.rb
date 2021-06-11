class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :body, null: false
      t.integer :genre
      t.string  :post_image_id
      t.integer :exercise_intensity
      t.integer :exercise_time, null: false

      t.timestamps
    end
  end
end
