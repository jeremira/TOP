require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup 
  	@user 		= users(:babar)
  	@other_user = users(:kakoo)
  end

end
