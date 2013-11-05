class Ability
  include CanCan::Ability

  def initialize(user)
    # guest - someone who is not logged in. can only see public wikis and public pages
    user ||= User.new

    alias_action :create, :read, :edit, to: :access_level_2_actions

    # member - can create/manage their own wikis and pages
    if user.role? :member
      can :manage, Wiki, owner_id: user.id
      access_level_2_wikis = user.collaborators.select {|c| c.access_level == 2}.collect(&:wiki_id) 
      can :access_level_2_actions, Wiki, id: access_level_2_wikis
    elsif user.role? :admin
      can :manage, :all
    else
      can :read, Wiki, public: true
    end
  end
end
