class CreateLearningPaths < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_paths do |t|
      t.string :title, null: false
      t.text :description
      t.integer :difficulty_level, null: false, default: 1
      t.integer :estimated_hours
      t.integer :total_lessons
      t.boolean :is_published, default: true

      t.timestamps
    end
    
    add_index :learning_paths, :difficulty_level
    add_index :learning_paths, :is_published
  end
end
