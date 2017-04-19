class ChangeCollumnToSystemMessage < ActiveRecord::Migration
  def change
    change_column_null :system_messages, :user_id, false
    change_column_null :system_messages, :message_type, false
  end
end
