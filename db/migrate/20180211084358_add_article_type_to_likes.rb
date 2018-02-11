class AddArticleTypeToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :article_type, :string
  end
end
