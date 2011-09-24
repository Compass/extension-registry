require 'image_uploader'
class Extension < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
end
