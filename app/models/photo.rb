class Photo < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  acts_as_votable
end
