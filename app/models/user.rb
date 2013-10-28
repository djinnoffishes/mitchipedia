class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  before_create :set_member

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :password, exclusion: {in: ["Password"],
    message: "must be changed." }
  validates :name, presence: true
  
  has_many :collaborators
  has_many :wiki_memberships, through: :collaborators, class_name: "Wiki", source: :wiki
  has_many :wiki_ownerships, foreign_key: :owner_id, class_name: "Wiki"

  def wikis
    wiki_ownerships + wiki_memberships
  end

  ROLES = %w[member admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def set_member
    self.role = "member"
  end

end
