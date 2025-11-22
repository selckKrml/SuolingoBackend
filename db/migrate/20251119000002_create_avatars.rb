class CreateAvatars < ActiveRecord::Migration[8.1]
  def change
    create_table :avatars do |t|
      t.string :name
      t.string :voice_id
      t.text :personality
      t.string :image_url

      t.timestamps
    end
  end
end
