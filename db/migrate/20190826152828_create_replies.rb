class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.string :message
      t.string :shortname
      t.integer :reply_to
      t.timestamp :sent_at

      t.timestamps
    end
  end
end
