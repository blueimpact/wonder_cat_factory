module ApplicationHelper
  def display_date time
    if time
      if time.future?
        distance_of_time_in_words_to_now(time) + I18n.t('datetime.after')
      else
        distance_of_time_in_words_to_now(time) + I18n.t('datetime.ago')
      end
    end
  end
end
