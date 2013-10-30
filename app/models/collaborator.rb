class Collaborator < ActiveRecord::Base

  self.table_name = 'users_wikis'
  
  belongs_to :user
  belongs_to :wiki

  delegate :name, to: :user, allow_nil: true
  delegate :email, to: :user, allow_nil: true

end