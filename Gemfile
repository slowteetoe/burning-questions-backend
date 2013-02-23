source "https://rubygems.org"
ruby "1.9.2"
gem "sinatra", :require => "sinatra/base"
gem 'sinatra-reloader', require: 'sinatra/reloader'

gem 'data_mapper'
gem 'dm-sqlite-adapter'
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'rspec'
end
group :production do
  gem 'pg', :require => 'pg'
end
