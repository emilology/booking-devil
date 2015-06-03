require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get tables" do
    get :tables
    assert_response :success
  end

end
