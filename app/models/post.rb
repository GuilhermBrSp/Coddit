class Post < ApplicationRecord
  validates :body, :title, presence: true
  has_many :comments, as: :commentable
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :favorites
  after_create :notify_users


    def notify_users
        self.tags.joins(:subscriptions)
        .select('subscriptions.email')
        .distinct
                .map {|subscription| UserMailer.with(post:self, user_email: subscription.email  ).notify.deliver_now! }

    end

    def self.tagged_with(name)
      Tag.find_by!(name: name).posts
    end

    def self.tag_counts
      Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end

    def tag_list
      tags.map(&:name).join(', ')
    end

    def tag_list=(names)
      self.tags = names.split(',').map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
    end
  end
