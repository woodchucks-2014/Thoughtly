class AddRelatedCategoriesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :related_categories, :string
  end
end
