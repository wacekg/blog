class ChangeTableLikes < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key(:likes, :articles)
    remove_index(:likes, column: [:user_id, :article_id])
    rename_column(:likes, :article_id, :likeable_id)
    rename_column(:likes, :article_type, :likeable_type)
    add_index(:likes, [:user_id, :likeable_id, :likeable_type], unique: true)

  end
end
