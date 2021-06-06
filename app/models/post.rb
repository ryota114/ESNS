class Post < ApplicationRecord

  enum genre: { "ダイエット": 0, "筋トレ": 1, "スポーツ": 2, "生活": 3, "食事": 4, "その他": 5 }
  enum exercise_intensity: { "かなりゆるい": 0, "ゆるい": 1, "普通": 2, "ハード": 3, "かなりハード": 4, "運動なし": 5 }
  # もっと良い時間の選択方法がないか模索する
  enum exercise_time: { "0": 0, "5": 1, "10": 2, "15": 3, "30": 4, "45": 5, "60": 6, "75": 7, "90": 8, "105": 9, "120": 10, "150": 11, "180": 12 }

  attachment :post_image

  belongs_to:user
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many:bookmarks, dependent: :destroy
  has_many:notifications, dependent: :destroy

  validates :body, {presence: true,length: {maximum: 140}}
  validates :genre, presence: true
  validates :exercise_intensity, presence: true


  # 検索時にgenreかbodyカラムに部分一致する場合検索結果とする
  def self.search(keyword)
    where([ "genre like? OR body like?", "%#{keyword}%", "%#{keyword}%" ])
  end

  # ブックマーク時にすでにブックマークしているか確認
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # いいね時にすでにいいねしているか確認
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
