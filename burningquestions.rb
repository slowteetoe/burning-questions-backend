require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/cross_origin'
require 'json'
require 'data_mapper'

class BurningQuestions < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::CrossOrigin

  configure do
  	enable :cross_origin

    DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{Dir.pwd}/development.sqlite3"))    
    DataMapper.auto_upgrade!
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


  end

  post "/contact/register" do



  end 

  get "/contact/:first/:last" do
  	[].to_json
  end

  post "/contact/register" do
  	#
  end

  post "/contact/:id/details" do
  end

end

class Patient
  include DataMapper::Resource

  has n, :relationships
  has n, :contacts, :through => :relationships, :model => 'Patient'

  has n, :treatments
  has n, :tests

  property :first_name, Text
  property :last_name, Text
  property :initial_clinic_visit, DateTime
  property :stage, Integer
  property :symptoms_appeared, DateTime
end

class Relationship
  include DataMapper::Resource

  belongs_to :patient
  belongs_to :contact, :model => 'Patient' 
end

class Treatment
  include DataMapper::Resource

  belongs_to :patient
  property :method, Text
  property :treatment_date, Text
end

class Test
  include DataMapper::Resource
  belongs_to :patient
  property :test, Text
  property :test_date, Text
end







# create (456 {first_name: "Jose", last_name: "Cuervo", initial_clinic_visit: "2013-02-23T11:45:09-08:00")

