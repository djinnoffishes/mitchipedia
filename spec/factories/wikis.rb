# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "MyString"
    public false
    user_id 1
  end
end
