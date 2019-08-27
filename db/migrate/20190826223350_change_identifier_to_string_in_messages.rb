class ChangeIdentifierToStringInMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :identifier, :string
  end
end
