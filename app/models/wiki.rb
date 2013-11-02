class Wiki < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :collaborators
  has_many :users, through: :collaborators
  has_many :pages

  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }

  validates :title, presence: true
  validates_length_of :description, minimum: 20

end
