class CreateConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :conversations do |t|
      t.string :title
      t.integer :difficulty_level
      t.references :target_language, null: false, foreign_key: true
      t.references :avatar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
