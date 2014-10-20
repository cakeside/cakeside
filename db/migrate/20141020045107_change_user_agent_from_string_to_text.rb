class ChangeUserAgentFromStringToText < ActiveRecord::Migration
  def up
    change_column :user_sessions, :user_agent, :text
  end

  def down
    change_column :user_sessions, :user_agent, :string
  end
end
