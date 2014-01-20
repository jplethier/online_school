class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.admin
      can :manage, Account, id: user.account_id
      can :manage, Classroom, account_id: user.account_id
      can :manage, User, account_id: user.account_id
      can :manage, Group, account_id: user.account_id
      can :manage, Exam, account_id: user.account_id
      can :index, :dashboard
      can :show,  :settings
    end

    if user.student
      can :index, :dashboard
      can :read, Classroom do |classroom|
        classroom.user_groups.where(user_id: user.id).exists?
      end
    end
  end
end
