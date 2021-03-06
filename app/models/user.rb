class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  # フォロー・フォロワー
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  # 通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # ランキング
  has_many :liked_posts, through: :likes, source: :post

  validates :name, { length: { maximum: 15 } }

  # フォローするとき
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォロー解除するとき
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # フォローしているか確認するとき
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # フォロー通知
  def create_notification_follow(current_user)
    notificationed = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, "follow"])
    if notificationed.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end
end
