class ApplicationMailer < ActionMailer::Base
  default from: "#{I18n.t('mailers.sender_label')} <#{Settings.mail.sender}>"
  layout 'mailer'
end
