source "https://rubygems.org"
ruby "1.9.2"
gem "sinatra", :require => "sinatra/base"
gem 'sinatra-reloader', require: 'sinatra/reloader'

gem 'data_mapper'
group :development, :test do
  gem 'dm-sqlite-adapter'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'rspec'
end
group :production do
  gem 'dm-postgres-adapter'
  gem 'pg', :require => 'pg'
end
