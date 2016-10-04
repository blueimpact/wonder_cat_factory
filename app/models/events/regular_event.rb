class Events::RegularEvent < Event
  def to_message
    I18n.t 'message',
           scope: [ActiveRecord::Base.i18n_scope,
                   :events,
                   self.class.model_name.element]
  end
end
