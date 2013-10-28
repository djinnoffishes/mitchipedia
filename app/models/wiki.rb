class Wiki < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :collaborators
  has_many :users, through: :collaborators
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
