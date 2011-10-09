require 'spec_helper'

describe Extension do


  it "fails validation with no name" do
    Extension.new.should have(1).error_on(:name)
  end
  
  it "fails validation on image" do
    Extension.new.should have(1).error_on(:image)
  end


  context "ruby gem integration" do
    before do
      @new_ext = Extension.new(:name => 'som ext', :image => File.new(Rails.root.join('spec/factories', 'extension_test.png')), :ruby_gem => 'compass')
    end
    it "should load gem data" do
      Gems.expects(:versions).once.returns(Gems.versions)
      Gems.expects(:info).once.returns(Gems.info)
      Timecop.freeze do
        @new_ext.gem_version_cache.should be_blank
        @new_ext.gem_version_last_updated.should be_blank
        @new_ext.ruby_gem_cache.should be_blank
        @new_ext.ruby_gem_cache_last_updted.should be_blank
        @new_ext.save
        @new_ext.gem_version_cache.should_not be_blank
        @new_ext.gem_version_last_updated.should_not be_blank
        @new_ext.gem_version_last_updated.to_i.should == Time.now.to_i
        @new_ext.ruby_gem_cache.should_not be_blank
        @new_ext.ruby_gem_cache_last_updted.should_not be_blank
        @new_ext.ruby_gem_cache_last_updted.to_i.should == Time.now.to_i
        @new_ext.gem_versions.should_not be_blank
        @new_ext.gem_information.should_not be_blank
      end
    end
    
    it "should be expired" do
      @new_ext.stubs(:gem_version_last_updated).returns(Time.now)
      Timecop.freeze(2.hours.from_now) do
        @new_ext.send(:expired?, :gem_version_last_updated).should be_true
      end
    end
    
    it "should not be expired" do
      Timecop.freeze(1.hour.from_now) do
        @new_ext.stubs(:gem_version_last_updated).returns(30.minutes.ago)
        @new_ext.send(:expired?, :gem_version_last_updated).should be_false
      end
    end
    
    it "should only load from the api once" do
      
    end
    
  end


end
