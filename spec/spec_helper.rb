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
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/burningquestions.db")
  DataMapper.finalize
  Patient.auto_migrate!
  Relationship.auto_migrate!
  Treatment.auto_migrate!
  Test.auto_migrate!
end