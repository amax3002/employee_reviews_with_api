require_relative "dependencies"
require_relative "./development"
require './migrations.rb'
require './department.rb'
require 'pry'



class App < Sinatra::Base

  #http://localhost:4567/list_employees
  get "/list_employees" do
    content_type "application/json"
    Employee.all.to_json
  end

  #http://localhost:4567/specific_employee?name=Jerkface
  get "/specific_employee" do
    content_type "application/json"
    Employee.find_by(name: params["name"]).to_json
  end

  #http://localhost:4567/create_employee?name=AlexGuy
  post "/create_employee" do
    content_type "application/json"
    Employee.create!(name: params["name"], email: params["email"], phone: params["phone"], salary: params["salary"]).to_json
  end

  #http://localhost:4567/delete_employee?name=Jerkface
  delete "/delete_employee" do
    content_type "application/json"
    a = Employee.where(name: params["name"])
    a.delete_all
  end


  patch "/change_employee_name" do
    content_type "application/json"
    Employee.find_by(name: params["name"]).update(name: params["name_update"])
  end

  run! if app_file == $PROGRAM_NAME

end
