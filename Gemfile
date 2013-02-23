source "https://rubygems.org"
ruby "1.9.2"
gem "sinatra", :require => "sinatra/base"
gem 'sinatra-reloader', require: 'sinatra/reloader'
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
group :production do
  gem 'pg', :require => 'pg'
end
