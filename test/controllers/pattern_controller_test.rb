require 'test_helper'

class PatternControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get pattern_index_url
    assert_response :success
  end
end
