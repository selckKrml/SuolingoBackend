class AddLanguageToAvatars < ActiveRecord::Migration[8.1]
  def change
    add_column :avatars, :language, :string, null: false, default: 'English'
    add_column :avatars, :language_code, :string, null: false, default: 'en-US'
    
    add_index :avatars, :language
    add_index :avatars, :language_code
  end
end
