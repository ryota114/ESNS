class Post < ApplicationRecord

  enum genre: { "ダイエット": 0, "筋トレ": 1, "スポーツ": 2, "生活": 3, "食事": 4, "その他": 5 }
  enum exercise_intensity: { "かなりゆるい": 0, "ゆるい": 1, "普通": 2, "ハード": 3, "かなりハード": 4, "運動なし": 5 }
  # もっと良い時間の選択方法がないか模索する
  enum exercise_time: { "0": 0, "5": 1, "10": 2, "15": 3, "30": 4, "45": 5, "60": 6, "75": 7, "90": 8, "105": 9, "120": 10, "150": 11, "180": 12 }

  attachment :post_image

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # ランキング
  has_many :liked_users, through: :likes, source: :user

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

  # いいね通知
  def create_notification_like(current_user)
    # すでにいいねされているかレコードの存在をifでチェック
    notificationed = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "like"])
    if notificationed.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "like"
      )
      # 自分の投稿に対するいいねは通知済みとして処理する
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知
  # 自分以外に該当記事に対してコメントしている人を全て取得し、全てに通知を送る
  def create_notification_comment(current_user, comment_id)
    commented_users = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    commented_users.each do |commented_user|
      save_notification_comment(current_user, comment_id, commented_user["user_id"])
    end
    # まだ誰もコメントしていない場合は、投稿者のみに通知を送る
    save_notification_comment(current_user, comment_id, user_id) if commented_users.blank?
  end

  # コメント通知の保存,create_notification_commnet内で使用
  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end
end
