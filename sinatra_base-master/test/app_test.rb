require "./test/test_helper"
require './migrations.rb'
require './department.rb'

class AppTest < Minitest::Test
  include Rack::Test::Methods


  def app
    App
  end

  def test_get_all_employees
    response = get "/list_employees"
    assert response.ok?
    refute_equal nil, response.body
  end

  def test_get_specific_employee
    response = get "/specific_employee?name=Ben"
    payload = JSON.parse(response.body)
    assert_equal "Ben", payload["name"]
  end

  def test_create_new_employee
    response = post "/create_employee?name=Thomas&email=whatemail@gmail.com&phone=666&salary=78666"
    payload = JSON.parse(response.body)
    assert_equal "Thomas", payload["name"]
  end

  def test_update_employee
    response = patch "/change_employee_name?name=Jerkface&name_update=Obama"
    #payload = JSON.parse(response.body)
    assert_equal "Obama",response.body
  end

end
