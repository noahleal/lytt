class ChangeIdentifierToStringInSessions < ActiveRecord::Migration[6.0]
  def change
    change_column :sessions, :identifier, :string
  end
end
