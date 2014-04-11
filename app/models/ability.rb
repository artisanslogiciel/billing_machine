class Ability
  include CanCan::Ability

  def initialize(user)
    can :write, TimeSlice do |ts|
       ts.user == user
    end
    
    can [:write, :read], Invoice do |i|
       i.entity_id == user.entity_id
    end
  end
end
