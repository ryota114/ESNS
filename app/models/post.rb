class Post < ApplicationRecord

  enum genre: { "その他": 0, "ダイエット": 1, "筋トレ": 2, "スポーツ": 3, "生活": 4, "食事": 5 }
  enum exercise_intensity: { "かなりゆるい": 0, "ゆるい": 1, "普通": 2, "ハード": 3, "かなりハード": 4 }

  belongs_to:user
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many:bookmarks, dependent: :destroy
  has_many:notifications, dependent: :destroy

end
