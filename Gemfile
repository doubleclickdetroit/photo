source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'thin'

gem 'jquery-rails'
gem 'haml-rails'
gem 'html5-rails', :git => 'git://github.com/sporkd/html5-rails.git'

gem 'requirejs-rails'

group :development, :test do
  gem 'sqlite3'
end

# heroku postgre
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass', '0.12.alpha.2'
  gem 'compass-h5bp'
end

group :development, :test do
  gem 'therubyracer'

  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false

  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'selenium-client'
  gem 'selenium-webdriver'
	gem 'launchy'
	gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
  # gem 'guard-rails-assets'
	gem 'factory_girl_rails'
end
