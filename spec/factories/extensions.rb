# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :extension do
    sequence :name do |n|
      "compass #{n}"
     end
     image File.new(File.join(File.expand_path('../', __FILE__), 'extension_test.png'))
     ruby_gem "compass"
     association :user, :factory => :user
    end
end