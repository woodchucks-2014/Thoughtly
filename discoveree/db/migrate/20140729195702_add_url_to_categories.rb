class AddUrlToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :url, :text
  end
end
