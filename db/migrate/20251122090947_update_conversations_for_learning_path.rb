class UpdateConversationsForLearningPath < ActiveRecord::Migration[8.1]
  def change
    # target_language_id'yi kaldır
    remove_reference :conversations, :target_language, foreign_key: true, if_exists: true
    
    # learning_path_id ekle (index add_reference tarafından otomatik oluşturulur)
    add_reference :conversations, :learning_path, foreign_key: true
  end
end
