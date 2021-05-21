class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.reference :user_id, null: false
      t.reference :post_id, null: false

      t.timestamps
    end
  end
end
