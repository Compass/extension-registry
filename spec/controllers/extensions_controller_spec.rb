require 'spec_helper'

describe ExtensionsController do
  let(:accept_json!) { request.env['HTTP_ACCEPT'] = 'application/json' }
  describe "GET 'index'" do
    
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should return releases paginated" do
      get :index
      30.times { Factory(:extension) }
      assigns[:extensions].size.should == 12
    end
    
    it "should get json" do
      accept_json!
      30.times { Factory(:extension) }
      get :index
      assigns[:extensions].size.should == 30
    end
    
  end
  
  describe 'search' do
    let(:foo) { Factory(:extension, :name => 'foo') }
    before do 
      10.times { Factory(:extension) }
      foo 
      get :index, :q => 'foo'
    end
    
    it 'should search and return results for foo' do
      assigns[:extensions].should == [ foo ]
    end
    
  end
  
  describe "GET 'new'" do
    context "logged in" do
      before do
        login!
        get :new
      end
    
      it "should be successful" do
        response.should be_successful
      end
    end
    
    context "not logged in" do
      before(:each) do
        get :new
      end
      
      it "should redirect to login page" do
        response.should redirect_to new_user_session_path
      end
    end
    
  end
  
  describe "POST 'create'" do
    context "logged in" do
      before do
        login!
        post :create, :extension => {:name => 'boobar'}
      end
      
      it "should assign extension" do
        assigns[:extension].should_not be_nil
      end
      
      it "should be successful" do
         response.should redirect_to extension_path assigns[:extension]
       end
      
    end
    
    context "not logged in" do
      before do
        post :create
      end
      
      it "should redirect" do
        response.should redirect_to new_user_session_path
      end
    end
  end

end
