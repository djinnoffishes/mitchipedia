class Ability
  include CanCan::Ability

  def initialize(user)
    # guest - someone who is not logged in. can only see public wikis and public pages
    user ||= User.new

    # member - can create/manage their own wikis and pages
    if user.role? :member
      can :manage, Wiki, owner_id: user.id
      user.collaborators.each do |c|
        if c.access_level == 2
          can :edit, Wiki, id: c.wiki_id
          can :read, Wiki, id: c.wiki_id
          can :create, Wiki, id: c.wiki_id
          return
        elsif c.access_level == 1
          can :read, Wiki, id: c.wiki_id
          cannot :edit, Wiki, id: c.wiki_id
          can :create, Wiki, id: c.wiki_id
          return
        end
      end
    elsif user.role? :admin
      can :manage, :all
    else
      can :read, Wiki, public: true
    end
  end
end
