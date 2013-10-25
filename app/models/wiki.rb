class Wiki < ActiveRecord::Base
  has_and_belongs_to_many :collaborators, class_name: User
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
