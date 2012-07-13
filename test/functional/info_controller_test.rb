require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "should get who_boutht" do
    get :who_boutht
    assert_response :success
  end

end
