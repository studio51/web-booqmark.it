# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookmark do
    title "MyString"
    url "MyText"
    name "MyString"
    description "MyString"
    thumbnail "MyString"
  end
end
