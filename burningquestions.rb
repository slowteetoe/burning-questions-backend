require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'data_mapper'

class BurningQuestions < Sinatra::Base
  register Sinatra::Reloader

  configure do
    enable :logging
    DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{Dir.pwd}/db/burning_questions.db"))
    DataMapper.auto_upgrade!
  end

  before do
  	response.headers["Access-Control-Allow-Origin"] = "*"
  	response.headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
  end

  get "/" do
  	"Welcome to burning questions"
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

  get "/setupTest" do
    p = Patient.new
    p.first_name = 'Jose'
    p.last_name = 'Cuervo'
    p.initial_clinic_visit = DateTime.now() - 63
    p.save
    p.to_json
  end

## Done
  get "/contact/:contact_id/links" do
    patient = Patient.get(params[:contact_id])

  	patient.contacts.to_json
  end

## Done
  get "/contact/:contact_id" do
    logger.info("Looking for contact id #{params[:contact_id]}")
    patient = Patient.get(params[:contact_id])

    patient.to_json
  end

  get "/contact/:first/:last" do
    patients = Patient.all({ :first_name => params[:first], :last_name => params[:last]})

    patients.to_json
  end


## Done
  post "/contact/register" do
  	logger.info("Registering #{params[:firstName]} #{params[:lastName]}")
    p = Patient.new({:first_name => params[:firstName], :last_name => params[:lastName] }).save
    p.to_json
  end

## Done
  post "/contact/:patient_id/link/:target_id" do
    logger.info("Connecting #{params[:patient_id]} to #{params[:target_id]}")
    patient = Patient.get(params[:patient_id])
    logger.info(patient.to_json)
    target = Patient.get(params[:target_id])

    patient.contacts << target
    patient.save

    logger.info(patient.contacts.to_json)
  	halt 200
  end
end

class Patient
  include DataMapper::Resource

  has n, :patient_relationships, :child_key => [ :patient_id ]
  has n, :contacts, self, :through => :patient_relationships, :via => :contact
 
  # property :id, Serial
  
  has n, :treatments
  has n, :tests

  property :patient_id, Serial

  property :first_name, Text
  property :last_name, Text
  property :initial_clinic_visit, DateTime
  property :stage, Integer
  property :symptoms_appeared, DateTime
end

class PatientRelationship
  include DataMapper::Resource
 
  belongs_to :patient, 'Patient', :key => true
  belongs_to :contact, 'Patient', :key => true
 
  property :contact_id, Serial
end

class Treatment
  include DataMapper::Resource
  belongs_to :patient

  property :id, Serial
  property :method, Text
  property :treatment_date, Text
end

class Test
  include DataMapper::Resource
  belongs_to :patient

  property :id, Serial
  property :test, Text
  property :test_date, Text
end
