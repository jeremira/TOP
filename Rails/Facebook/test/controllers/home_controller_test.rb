require 'test_helper'
#include Devise::Test::IntegrationHelpers

class HomeControllerTest < ActionDispatch::IntegrationTest

  def setup 
  	@user = users(:babar)
  end
 
  test "should get root for non logged in user" do
    get root_url
    assert_response :success
    #assert_current_path('/posts/index')
  end

  test "should redirect a login user" do 
  	 get user_session_path
     assert_equal 200, status
     @david = User.create(email: "david@mail.com", password: Devise::Encryptor.digest(User, "helloworld"))
     post user_session_path, params:{'user[email]' => @david.email, 'user[password]' =>  @david.password}
     #post user_session_path,   :params {'user[email]': @david.email, 'user[password]': @david.password }
     #post user_session_path \ 'user[email]' => @david.email, 'user[password]' =>  @david.password
     follow_redirect!
     assert_response :found
     assert_redirected_to  user_path(@david.id)
  end
  
end
