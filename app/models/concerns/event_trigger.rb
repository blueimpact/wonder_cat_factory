module EventTrigger
  extend ActiveSupport::Concern

  module ClassMethods
    def triggers event_class, attr
      after_save do
        event_class.trigger self if changes.key? attr
      end
    end
  end
end
