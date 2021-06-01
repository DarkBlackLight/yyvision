class Ability::AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, :all

    cannot [:update], Upload
    cannot [:create, :update], Attendance
    cannot [:create, :update], CameraCapture
    cannot [:create, :update], LocationEvent
  end
end