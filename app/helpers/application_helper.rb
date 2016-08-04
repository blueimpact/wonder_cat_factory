module ApplicationHelper
  def user_label_for user
    (user == current_user) ? t('nav.my_products') : user
  end

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
