class Page < ActiveRecord::Base

  belongs_to :wikis

  has_many :users

  validates :title, presence: true
  validates_length_of :body, minimum: 20

end