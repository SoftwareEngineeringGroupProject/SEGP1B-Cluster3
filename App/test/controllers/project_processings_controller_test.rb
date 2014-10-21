require 'test_helper'

class ProjectProcessingsControllerTest < ActionController::TestCase
  test "should get edit_project" do
    get :edit_project
    assert_response :success
  end

  test "should get assign_student" do
    get :assign_student
    assert_response :success
  end

end
