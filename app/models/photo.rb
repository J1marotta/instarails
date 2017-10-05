class Photo < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
  belongs_to :user
  acts_as_votable
  default_scope -> { order(created_at: :desc) }

end
