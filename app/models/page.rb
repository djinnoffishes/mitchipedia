class Page < ActiveRecord::Base

  belongs_to :wiki

  has_many :users

  validates :title, presence: true
  validates_length_of :body, minimum: 20

end