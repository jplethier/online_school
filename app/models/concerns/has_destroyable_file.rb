require 'active_support/concern'

module HasDestroyableFile
  extend ActiveSupport::Concern

  module ClassMethods
    def has_destroyable_file(*attachments)
      attachments.each do |attachment|
        attr_accessor :"#{attachment}_delete"

        before_save do
          self.send(attachment).clear if self.send(:"#{attachment}_delete") == '1'
        end
      end
    end
  end
end

