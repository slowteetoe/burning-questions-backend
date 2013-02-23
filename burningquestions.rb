require 'sinatra/base'
require 'sinatra/reloader'
require 'json'

class BurningQuestions < Sinatra::Base
  register Sinatra::Reloader

  before do
  	response.headers["Access-Control-Allow-Origin"] = "*"
  	response.headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
  end

  get "/patient/:patient_id" do
    {
      :patient => { :id => params[:patient_id], :first_name => "Jose", :last_name => "Cuervo", :initial_clinic_visit => DateTime.now, :stage => { :id => 2, :symptoms_appeared => DateTime.now - 21 }, :treatments => [ ], :tests => [ :date => DateTime.now - 2, :result => "positive" ]},
      :contacts => [
        { :id => 456, :first_name => "Harvey", :last_name => "Wallbanger", :initial_clinic_visit => nil, :stage => {}, :treatments => [ ], :tests => [] },
        { :id => 567, :first_name => "Tom", :last_name => "Collins", :initial_clinic_visit => DateTime.now - 63, :stage => { :id=> 3, :symptoms_appeared => DateTime.now - 65 }, :treatments => [{ :date => DateTime.now - 65, :method => "Tetracycline 500 mg orally four times daily for 14 days"}], :tests => [ ]}
      ]
    }.to_json
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
