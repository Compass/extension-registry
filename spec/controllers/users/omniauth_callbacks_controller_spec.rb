require 'spec_helper'

describe Users::OmniauthCallbacksController do

  before do
    @user = Factory(:user)
  end
  
  it "should login from github callback" do
    mock_omni_auth_user(@user.email)
    get :github
    response.should redirect_to root_path
  end

end
