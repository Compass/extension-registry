# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :extension do
    sequence :name do |n|
      "My extensions #{n}"
     end
     image File.new(File.join(File.expand_path('../', __FILE__), 'extension_test.png'))
     ruby_gem "compass"
     association :user, :factory => :user
     homepage 'http://compass-style.org'
     source_code 'http://github.com/compass'
     documentation 'http://rdoc.info/compass'
     mailing_list 'http://mail.google.com'
    end
end