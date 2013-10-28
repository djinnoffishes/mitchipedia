class Collaborator < ActiveRecord::Base

  self.table_name = 'users_wikis'
  
  belongs_to :user
  belongs_to :wiki

end