module Payloader
  module GenerateUuid
    extend ActiveSupport::Concern
    included do

      before_create :generate_uuid

      private

      def generate_uuid
        self.uuid = loop do
          random_token = SecureRandom.hex
          break random_token unless self.class.exists?(uuid: random_token)
        end
      end

    end
  end
end