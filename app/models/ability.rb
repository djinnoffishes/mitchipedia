class Ability
  include CanCan::Ability

  def initialize(user)
    # guest - someone who is not logged in. can only see public wikis and public pages
    user ||= User.new

    # member - can create/manage their own wikis and pages
    if user.role? :member
      can :manage, Wiki, owner_id: user.id
      # TODO -- parmission to manage pages if permitted
      # TODO -- parmission to read pages if permitted
      # TODO -- parmission to read public
    # admin - can manage all wikis and all pages
    elsif user.role? :admin
      can :manage, :all

    else
      can :read, Wiki, public: true
    end
  end
end
