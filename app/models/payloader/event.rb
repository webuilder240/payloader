module Payloader
  class Event < ActiveRecord::Base
    include Payloader::GenerateUuid
    belongs_to :site
    belongs_to :site_url
    validates :event_type, presence: true, length: {maximum: 255}
    validates :body, presence: true
  end
end
