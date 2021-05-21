class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :body, null: false
      t.string :exercise_intensity, default: 0, null: false
      t.integer :exercise_time, default: 0, null: false

      t.timestamps
    end
  end
end
