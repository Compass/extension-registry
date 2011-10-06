# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'



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
  end
  
end