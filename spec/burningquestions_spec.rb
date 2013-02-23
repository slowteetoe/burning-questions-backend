require 'spec_helper'
require 'pp'

describe "Sinatra App" do
  it "should respond to GET" do
    get '/'
    pp last_response
    last_response.should be_ok
    last_response.body.should match(/Welcome to burning questions/)
  end
end
