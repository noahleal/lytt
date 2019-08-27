class AddLanguageCollumnToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :language, :string
  end
end
