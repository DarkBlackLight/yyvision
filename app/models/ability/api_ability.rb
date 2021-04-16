class Ability::ApiAbility
  include CanCan::Ability

  def initialize(user)

    if user
      if user.source.class.name == 'Admin'
        can :manage, Bank
        can :manage, Person
      end

      if user.source.class.name == 'Engine'
        can :read, Engine
        can :read, Location
        can :read, Event
        can :read, Portrait
        can :read, Holiday

        can :update, Camera
        can :create, CameraCapture
        can [:create, :update], LocationEvent
      end
    end
  end
end