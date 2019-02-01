class Tag < ApplicationRecord
  has_many :subscriptions
  has_many :taggings
  has_many :posts, through: :taggings


end
