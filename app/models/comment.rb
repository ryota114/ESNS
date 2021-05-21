class Comment < ApplicationRecord

  belongs_to:users
  belongs_to:post
  has_many:notifications, dependent: :destroy

end
