# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :extension do
    sequence :name do |n|
      "My extensions #{n}"
     end
     image Rails.root.join('spec', 'factories', 'extension_test.png').open
     ruby_gem "compass"
     association :user, :factory => :user
     homepage 'http://compass-style.org'
     source_code 'http://github.com/compass'
     documentation 'http://rdoc.info/compass'
     mailing_list 'http://mail.google.com'
    end
end