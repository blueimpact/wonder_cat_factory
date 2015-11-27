module ApplicationHelper
  def user_label_for user
    (user == current_user) ? t('nav.my_products') : user
  end
end
