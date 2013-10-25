class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
