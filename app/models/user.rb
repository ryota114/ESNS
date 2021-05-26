class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  has_many:comments, dependent: :destroy
  has_many:posts, dependent: :destroy
  has_many:bookmarks, dependent: :destroy
  has_many:relationships, dependent: :destroy
  has_many:notifications, dependent: :destroy
  has_many:likes, dependent: :destroy

  def self.search(keyword)
    where([ "name like?", "%#{keyword}%" ])
  end

end
