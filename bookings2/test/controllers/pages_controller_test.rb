require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get book" do
    get :book
    assert_response :success
  end

end
