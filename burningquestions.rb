require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
# neo4j_uri = URI(ENV['NEO4J_URL'] || 'http://localhost:7474') # This is how Heroku tells us about the app.
# neo = Neography::Rest.new(neo4j_uri.to_s) # Neography expects a string




class BurningQuestions < Sinatra::Base
  register Sinatra::Reloader

  configure do
  	enable :logging
  end

  before do
  	response.headers["Access-Control-Allow-Origin"] = "*"
  	response.headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
  end

  get "/patient/:patient_id" do
    {
      :patient => { :id => params[:patient_id], :first_name => "Jose", :last_name => "Cuervo", :initial_clinic_visit => DateTime.now, :stage => { :id => 2, :symptoms_appeared => DateTime.now - 21 }, :treatments => [ ], :tests => [ :date => DateTime.now - 2, :result => "positive" ]},
      :contacts => [
        { :id => 456, :first_name => "Harvey", :last_name => "Wallbanger", :initial_clinic_visit => nil, :stage => {}, :treatments => [ ], :tests => [], :first_contact_date => DateTime.now() - 63, :last_contact_date => DateTime.now() - 50, contact_types: ["oral"] },
        { :id => 567, :first_name => "Tom", :last_name => "Collins", :initial_clinic_visit => DateTime.now - 63, :stage => { :id=> 3, :symptoms_appeared => DateTime.now - 65 }, :treatments => [{ :date => DateTime.now - 65, :method => "Tetracycline 500 mg orally four times daily for 14 days"}], :tests => [ ], :first_contact_date => DateTime.now() - 63, :last_contact_date => DateTime.now() - 50, contact_types: ["oral"] }
      ]
    }.to_json
  end 

  get "/contact/:first/:last" do
  	[
	   {
	      "id" => 1,
	      "firstName" => "Rich",
	      "lastName" => "Hoppes"
	   },
	   {
	      "id" => 1000,
	      "firstName" => "Dick",
	      "lastName" => "Hoppes"
	   }
	].to_json
  end

  post "/contact/register" do
  	logger.info("Registering #{params[:firstName]} #{params[:lastName]}")
  	{ :id => 666 }.to_json
  end

  post "/contact/:contact_id/link/:target_id" do
  	logger.info("Connecting #{params[:contact_id]} to #{params[:target_id]}")
  	halt 200
  end

end

# create (456 {first_name: "Jose", last_name: "Cuervo", initial_clinic_visit: "2013-02-23T11:45:09-08:00")

