require 'spec_helper'

describe Users::OmniauthCallbacksController do
  
  context "github" do
    before do
      @controller.request.env["devise.mapping"] = Devise.mappings[:user] 
      @controller.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end
    
    it "should login rom github" do
      get :github
      response.should be_redirect
      response.should redirect_to root_path
      flash[:notice].should_not be_blank
    end
    
  end

end
