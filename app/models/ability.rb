class Ability
  include CanCan::Ability

  def initialize(user)
    # guest - someone who is not logged in. can only see public wikis and public pages
    user ||= User.new

    # member - can create/manage their own wikis and pages
    if user.role? :member
      can :manage, Wiki, user_id: user.id
      # TODO -- parmission to manage pages if permitted
      # TODO -- parmission to read pages if permitted
      # TODO -- parmission to read public
    end

    # admin - can manage all wikis and all pages
    if user.role? :admin
      can :manage, :all
    end

    can :read, Wiki, public: true
    # TODO -- parmission to read public
  end
end
