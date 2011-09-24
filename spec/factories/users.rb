# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "my.#{n}@email.com"
    end
    password Devise.friendly_token[0,20]
  end
end