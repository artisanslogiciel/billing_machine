class Ability
  include CanCan::Ability

  def initialize(user)

    if user.time_machine && user.entity.time_machine
      can [:write, :read], TimeSlice do |ts|
        ts.user == user
      end
    end

    if user.billing_machine && user.entity.billing_machine
      can [:write, :read], Invoice do |i|
        i.entity == user.entity
      end
    end

  end
end
