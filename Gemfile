source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'compass', :path => '../compass'
  gem 'compass-theme', :path => '../compass-theme' #:git => 'git://github.com/Compass/compass-theme.git'
  gem 'uglifier'
  gem 'fancy-buttons', '~> 1.1.2'
end

gem 'jquery-rails', '~> 1.0.14'
gem 'haml-rails', '~> 0.3.4'
gem 'foreigner', '~> 1.1.1'
gem 'devise', '~> 1.4.5'
gem "oa-oauth", :require => "omniauth/oauth"
gem 'kaminari', '~> 0.12.4'
gem 'carrierwave', '~> 0.5.7'
gem 'mini_magick'

group :test, :development do
  gem 'factory_girl_rails', '~> 1.2.0'
  gem 'rspec-rails', '~> 2.6.1'
  gem 'guard', '~> 0.6.3'
  gem 'rb-fsevent' if RbConfig::CONFIG['host_os'] =~ /darwin/
  gem 'growl_notify'
  gem 'compass-growl', :path => '../compass-growl'
  gem 'guard-rspec'
  gem 'mocha'
  gem 'jasmine-headless-webkit'
  gem 'guard-jasmine-headless-webkit'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
group :deploy do
  gem 'capistrano'
end
# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

