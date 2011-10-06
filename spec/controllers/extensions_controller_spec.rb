require 'spec_helper'

describe ExtensionsController do

  let(:alert) { flash[:alert] }

  describe "before_filters" do
    %w(edit update destroy).each do |method|
      it "should be fail user does not own this extension for #{method}" do
        ext = Factory(:extension)
        sign_in Factory(:user)
        get method, :id => ext.id 
        response.should redirect_to root_path
        alert.should_not be_blank
      end
      
      it "should rescue from record not found" do
        sign_in Factory(:user)
        get method, :id => -1
        response.should redirect_to root_path
        alert.should_not be_blank
      end
    end
  end

  describe "GET 'index'" do
    before do
      15.times { Factory(:extension) }
      get :index
    end
    it "should be successful" do
      response.should be_success
    end
    
    it "should paginate" do
      assigns(:extensions).size.should == 12
    end
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      sign_in Factory(:user)
      get :new
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      ext = Factory(:extension)
      sign_in ext.user
      get :edit, :id => ext.id 
      response.should be_success
    end
    
  end
  
  describe "POST 'create'" do
    before do
      @user = Factory(:user)
      sign_in(@user)
      post :create, :extension => Factory.attributes_for(:extension)
    end
    
    it "should be redirect_to #show" do
      response.should redirect_to extension_path(assigns[:extension])
    end
    
  end

end
