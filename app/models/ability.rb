class Ability
  include CanCan::Ability

  def initialize(user)
    # guest - someone who is not logged in. can only see public wikis and public pages
    user ||= User.new

    # member - can create/manage their own wikis and pages
    if user.role? :member
      can :manage, Wiki, owner_id: user.id
      # can :edit, Wiki do |w|
      #   w.collaborators.find_by_user_id == user.id
      # end
    # admin - can manage all wikis and all pages
    elsif user.role? :admin
      can :manage, :all

    else
      can :read, Wiki, public: true
    end
  end
end
