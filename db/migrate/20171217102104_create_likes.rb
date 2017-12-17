class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :article, foreign_key: true

      t.index [:user_id, :article_id], unique: true
    end
  end
end
