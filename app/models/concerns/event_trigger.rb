module EventTrigger
  extend ActiveSupport::Concern

  module ClassMethods
    def triggers event_class, attr
      after_save do
        if (change = changes[attr]) && change.first.nil?
          event_class.trigger self
        end
      end
    end
  end
end
