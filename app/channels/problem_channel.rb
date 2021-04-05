class ProblemChannel < ApplicationCable::Channel
  def subscribed
    stream_from "problems"
  end
end