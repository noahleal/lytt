class ChangeIdentifierToBeStringInReplies < ActiveRecord::Migration[6.0]
  def change
    change_column :replies, :reply_to, :string
  end
end
