class Ability
  include CanCan::Ability

  def initialize(user)
    can :write, TimeSlice do |ts|
       ts.user == user
    end
  end
end
