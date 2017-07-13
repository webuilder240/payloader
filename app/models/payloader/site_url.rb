module Payloader
  class SiteUrl < ActiveRecord::Base
    include Payloader::GenerateUuid
    belongs_to :site
    validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
  end
end
