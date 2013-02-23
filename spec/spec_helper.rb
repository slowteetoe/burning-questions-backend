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

RSpec.configure { |c| c.include RSpecMixin }