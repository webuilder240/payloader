class HomeController < ApplicationController
  def index
    event = Payloader::Event.first
    event.send_payload
  end
end