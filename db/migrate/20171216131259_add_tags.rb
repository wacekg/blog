class AddTags < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :tags, :text, array: true, default: []
  end
end
