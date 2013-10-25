# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "MyString"
    public false
    owner_id 1
  end
end
