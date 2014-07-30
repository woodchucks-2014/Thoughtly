class AddRelatedCategoriesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :related_categories, :string, array: true
  end
end
