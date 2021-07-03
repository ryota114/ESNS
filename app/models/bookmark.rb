class Bookmark < ApplicationRecord
  belongs_to:user
  belongs_to:post

  # ２回以上連続してブックマークすることを阻止する
  validates :post_id, uniqueness: { scope: :user_id }
end
