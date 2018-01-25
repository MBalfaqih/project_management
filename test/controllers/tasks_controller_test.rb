require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get V1::" do
    get tasks_V1::_url
    assert_response :success
  end

end
