class LocationEventChannel < ApplicationCable::Channel
  def subscribed
    stream_from "location_events"
  end
end