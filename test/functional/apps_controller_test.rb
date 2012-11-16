require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

end
