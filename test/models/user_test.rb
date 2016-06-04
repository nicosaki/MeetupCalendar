require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # Once you have enabled test mode, all requests
    # to OmniAuth will be short circuited
    # to use the mock authentication hash.
    # A request to /auth/provider will redirect
    # immediately to /auth/provider/callback.

    OmniAuth.config.test_mode = true

    # The mock_auth configuration allows you to
    # set per-provider (or default) authentication
    # hashes to return during testing.

    OmniAuth.config.mock_auth[:meetup] = OmniAuth::AuthHash.new({provider: 'meetup', uid: "24354", extra: {raw_info:{city: "Seattle"}}})
  end

  test "user is created by find_or_create_from_omniauth" do
    user = User.find_or_create_from_omniauth({provider: 'meetup', uid: "24354", extra: {raw_info:{city: "Seattle"}}})
    assert_instance_of User, user
  end


end
