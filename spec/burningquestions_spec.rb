require 'spec_helper'
require 'pp'

describe "Burning Questions" do
  it "should respond to GET" do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Welcome to burning questions/)
  end

  it "should store a relationship" do
  	get '/setupTest'
  	pp last_response
  	last_response.should be_ok
  end
end
