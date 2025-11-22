class CreateTargetLanguages < ActiveRecord::Migration[8.1]
  def change
    create_table :target_languages do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    
    add_index :target_languages, :code, unique: true
  end
end
