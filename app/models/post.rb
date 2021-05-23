class Post < ApplicationRecord

  enum genre: { "ダイエット": 0, "筋トレ": 1, "スポーツ": 2, "生活": 3, "食事": 4, "その他": 5 }
  enum exercise_intensity: { "かなりゆるい": 0, "ゆるい": 1, "普通": 2, "ハード": 3, "かなりハード": 4, "運動なし": 5 }

  attachment :post_image

  belongs_to:user
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many:bookmarks, dependent: :destroy
  has_many:notifications, dependent: :destroy

end
