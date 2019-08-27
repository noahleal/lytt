class AddSessionToReplies < ActiveRecord::Migration[6.0]
  def change
    add_reference :replies, :session, null: false, foreign_key: true
  end
end
