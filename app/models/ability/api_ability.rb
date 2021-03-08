class Ability::ApiAbility
  include CanCan::Ability

  def initialize(user)

    if user
      if user.source.class.name == 'Engine'
        can :read, Engine, id: user.source_id
        can :read, Location
        can :read, Event
        can :read, Portrait

        can :update, Camera
        can :create, CameraCapture
        can [:create, :update], LocationEvent
      end
    end
  end
end