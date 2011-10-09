require 'gems'
require 'yajl'
class Extension < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
   
  validates_presence_of :name, :image
  
  before_save :update_gem_cache
  
  serialize :ruby_gem_cache, Hash
  serialize :gem_version_cache, Array
  
  def update_gem_cache
    update_gem_version_cache
    update_gem_info
  end
  
  def update_gem_version_cache
    return false if self.ruby_gem.blank?
    if self.gem_version_cache.blank? || expired?(:gem_version_last_updated)
      self.gem_version_cache = get_gem_versions
      self.gem_version_last_updated = Time.now
    end
    self.gem_version_cache
  end
  
  def get_gem_versions
    Gems.versions self.ruby_gem
  end
  
  
  def gem_versions
    self.gem_version_cache
  end
  
  def update_gem_info
    return false if self.ruby_gem.blank?
    if self.ruby_gem_cache.blank? || expired?(:ruby_gem_cache_last_updted)
      self.ruby_gem_cache = get_gem_info
      self.ruby_gem_cache_last_updted = Time.now
    end
    self.ruby_gem_cache
  end
  
  def get_gem_info
    Gems.info self.ruby_gem
  end
  
  def gem_information
    self.ruby_gem_cache
  end
  
  private
  
  def expired?(col)
    (Time.now.to_i - self.send(col).to_i) >= 1.hour
  end
  
  
end
