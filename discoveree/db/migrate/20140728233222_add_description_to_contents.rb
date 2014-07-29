class AddDescriptionToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :description, :string
  end
end
