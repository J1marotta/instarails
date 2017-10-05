class Photo < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
  belongs_to :user
  acts_as_votable
end
