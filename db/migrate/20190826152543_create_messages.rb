class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :identifier
      t.string :detected_language
      t.datetime :timestamp
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
