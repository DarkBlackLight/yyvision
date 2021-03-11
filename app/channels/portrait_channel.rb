class PortraitChannel < ApplicationCable::Channel
  def subscribed
    stream_from "portraits"
  end
end