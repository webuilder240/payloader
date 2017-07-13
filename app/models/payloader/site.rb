module Payloader
  class Site < ActiveRecord::Base
    include Payloader::GenerateUuid
    before_create :generate_signature

    validates :name, presence: true, length: {maximum: 255}

    def generate_signature
      self.signature = loop do
        random_token = SecureRandom.hex
        break random_token unless self.class.exists?(signature: random_token)
      end
    end
  end
end
