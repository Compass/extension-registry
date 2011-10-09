# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "rack/test"
require 'yajl'

module OmniAuthHelper
  def mock_omni_auth_user(email)
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'extra' => {'user_hash' => {'email' => email}}
      # etc.
    }
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = controller.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end
  
  def mock_omni_auth_fails
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = controller.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end
  
  def accept_json!
    request.env['HTTP_ACCEPT'] = 'application/json'
  end
  
  def gem_versions(options={})
    (1..4).to_a.map do |i|
      {"built_at"=>"2011-10-05T00:00:00Z", "number"=>"0.0.#{1}", "prerelease"=>false, "authors"=>"Some Author", "description"=>"Some Description", "summary"=>"Some Summary", "downloads_count"=>i, "platform"=>"ruby"}.merge(options)
    end
  end
  
  def gem_info(options={})
    {"name"=>"growl_notify", "dependencies"=>{"runtime"=>[{"name"=>"Some Gem", "requirements"=>">= 0"}], "development"=>[]}, "downloads"=>12, "info"=>"Some info", "version"=>"0.0.3", "version_downloads"=>432, "homepage_uri"=>"https://github.com/scottdavis/growl_notify", "authors"=>"Scott Davis", "project_uri"=>"http://rubygems.org/gems/growl_notify", "gem_uri"=>"http://rubygems.org/gems/growl_notify-0.0.3.gem", "source_code_uri"=>nil, "bug_tracker_uri"=>nil, "wiki_uri"=>nil, "documentation_uri"=>nil, "mailing_list_uri"=>nil}.merge(options)
  end
  
  def mock_gems_requests
    Gems.stubs(:versions).returns(gem_versions)
    Gems.stubs(:info).returns(gem_info)
  end
  
end


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :mocha

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  
  config.include OmniAuthHelper
  config.before do
    OmniAuth.config.test_mode = true
    mock_gems_requests
  end
  
  config.after do
    FileUtils.rm_rf(Rails.root.join("spec/uploads/"))
  end
  
end