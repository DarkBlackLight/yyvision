class ApiController < ApplicationController
  include ManageApiControllerConcern
  before_action :setup_user_view

  def current_ability
    @current_ability ||= Ability::ApiAbility.new(@current_user)
  end

  def setup_user_view
    setup_view(@current_user)
  end
end