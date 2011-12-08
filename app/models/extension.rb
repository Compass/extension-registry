require 'gems'
class Extension < ActiveRecord::Base
  UNSTABLE_VERSIONS = %w(pre beta alpha)
  mount_uploader :image, ImageUploader
  belongs_to :user
   
  validates_presence_of :name, :image, :ruby_gem
  
  before_save :update_gem_cache
  
  serialize :ruby_gem_cache, Hash
  serialize :gem_version_cache, Array
  
  def update_gem_cache
    update_gem_version_cache
    update_gem_info
  end
  
  def update_gem_version_cache
    return nil if self.ruby_gem.blank?
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
    return nil if self.ruby_gem.blank?
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

  def stable_version
    @stable_version ||= begin
      self.gem_version_cache.map do |version|
        number = version['number']
        number unless UNSTABLE_VERSIONS.any? { |unstable| number.include?(unstable)}
      end.compact.first
    end
  end

  def latest_version
    @latest_version ||= self.gem_version_cache.first['number']
  end
  
  private
  
  def expired?(col)
    (Time.now.to_i - self.send(col).to_i) >= 1.hour
  end
  
  
end
