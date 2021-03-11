class CameraCaptureChannel < ApplicationCable::Channel
  def subscribed
    stream_from "camera_captures"
  end
end