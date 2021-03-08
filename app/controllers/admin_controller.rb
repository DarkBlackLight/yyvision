class AdminController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :authenticate_admin_type

  include AdminHelper
  include ManageControllerConcern

  def authenticate_admin_type
    unless current_admin_user.source_type == 'Admin'
      sign_out(:admin_user)
      redirect_to new_admin_user_session_path
    end
  end

  def current_ability
    @current_ability ||= Ability::AdminAbility.new(current_admin_user)
  end

  def setup_routes
    @routes = [
      {
        name: (t 'admin.layouts.sidebar.dashboard'),
        url: url_for({ controller: :dashboard, action: :index }),
        icon: "fas fa-tachometer-alt",
        can: (can? :index, :dashboard)
      },
      {
        name: LocationEvent.model_name.human,
        url: url_for({ controller: :location_events, action: :index }),
        icon: "far fa-bell",
        can: (can? :read, :banks)
      },
      {
        name: CameraCapture.model_name.human,
        url: url_for({ controller: :camera_captures, action: :index }),
        icon: "far fa-images",
        can: (can? :read, :camera_captures)
      },
      {
        name: PortraitSearch.model_name.human,
        url: url_for({ controller: :portrait_searches, action: :index }),
        icon: "fas fa-search",
        can: (can? :read, :portrait_searches)
      },
      {
        name: (t 'admin.layouts.sidebar.portrait_management'),
        url: url_for({ controller: :banks, action: :index }),
        icon: "fas fa-users",
        can: (can? :read, :banks) || (can? :read, :people),
        children: [
          { name: Bank.model_name.human,
            url: url_for({ controller: :banks, action: :index }),
            can: (can? :read, :banks)
          },
          {
            name: Person.model_name.human,
            url: url_for({ controller: :people, action: :index }),
            can: (can? :read, :people)
          }
        ]
      },
      {
        name: (t 'admin.layouts.sidebar.hardware_management'),
        url: url_for({ controller: :banks, action: :index }),
        icon: "fas fa-rocket",
        can: (can? :read, :banks) || (can? :read, :people),
        children: [
          {
            name: Camera.model_name.human,
            url: url_for({ controller: :cameras, action: :index }),
            can: (can? :read, :cameras)
          },
          {
            name: Engine.model_name.human,
            url: url_for({ controller: :engines, action: :index }),
            can: (can? :read, :engines)
          },
        ]
      },
      {
        name: Location.model_name.human,
        url: url_for({ controller: :locations, action: :index }),
        icon: "fas fa-thumbtack",
        can: (can? :read, :locations)
      },
      {
        name: Event.model_name.human,
        url: url_for({ controller: :events, action: :index }),
        icon: "far fa-bell",
        can: (can? :read, :events)
      },
      {
        name: Admin.model_name.human,
        url: url_for({ controller: :admins, action: :index }),
        icon: "fas fa-user-astronaut",
        can: (can? :read, :admins)
      },
    ]
  end
end