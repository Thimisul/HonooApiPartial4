require 'test_helper'

class MsgsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @msg = msgs(:one)
  end

  test "should get index" do
    get msgs_url, as: :json
    assert_response :success
  end

  test "should create msg" do
    assert_difference('Msg.count') do
      post msgs_url, params: { msg: { message: @msg.message, participantId: @msg.participantId } }, as: :json
    end

    assert_response 201
  end

  test "should show msg" do
    get msg_url(@msg), as: :json
    assert_response :success
  end

  test "should update msg" do
    patch msg_url(@msg), params: { msg: { message: @msg.message, participantId: @msg.participantId } }, as: :json
    assert_response 200
  end

  test "should destroy msg" do
    assert_difference('Msg.count', -1) do
      delete msg_url(@msg), as: :json
    end

    assert_response 204
  end
end
