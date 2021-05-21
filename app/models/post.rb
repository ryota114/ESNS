class Post < ApplicationRecord

  enum exercise_intensity: { "かなりゆるい": 0, "ゆるい": 1, "普通": 2, "ハード": 3, "かなりハード": 4 }

  belongs_to:user
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many:bookmarks, dependent: :destroy
  has_many:genres, dependent: :destroy
  has_many:notifications, dependent: :destroy

end
