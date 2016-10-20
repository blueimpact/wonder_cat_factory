class Events::RegularEvent < Event
  def to_message prefix = nil
    I18n.t [prefix, 'message'].compact.join('_'),
           scope: [ActiveRecord::Base.i18n_scope,
                   :events,
                   self.class.model_name.element]
  end
end
