require 'spec_helper'
require 'pp'

describe "Burning Questions" do

  it "should allow CORS universally" do
  	get '/'
  	last_response.should be_ok
  	last_response.header.fetch("Access-Control-Allow-Origin").should eql "*"
   	last_response.header.fetch("Access-Control-Allow-Methods").should eql "POST, GET, OPTIONS"
  end

  it "should respond to GET" do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Welcome to burning questions/)
  end

#  it "should store a relationship" do
#  	pending "Datamodel isn't working"
#  	get '/setupTest'
#  	pp last_response
#  	last_response.should be_ok
#  end

  describe "retrieving customer data" do
  	it "should retrieve a valid customer" do
  	  get '/contact/1'
  	  pp last_response
  	  last_response.should be_ok
  	  result = JSON.parse(last_response.body)
  	  result["first_name"].should eql "Joe"
  	  result["last_name"].should eql "Schmoe"
  	end
  end

  describe "adding a new contact" do
    it "should add a new contact" do
      post '/contact/register?firstName=Joe&lastName=Schmoe'
      pp last_response
      last_response.should be_ok
    end
  end

  describe "linking two patients" do 
    it "should link two patients" do
        post "/contact/1/link/2"
        pp last_response
        last_response.should be_ok
    end
  end

end
