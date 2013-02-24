require 'rack/test'

begin 
  require_relative '../burningquestions.rb'
rescue NameError
  require File.expand_path('../burningquestions.rb', __FILE__)
end

module RSpecMixin
  include Rack::Test::Methods
  def app() BurningQuestions end
end

RSpec.configure do |c|
  c.include RSpecMixin
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/burning_questions.db")
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
