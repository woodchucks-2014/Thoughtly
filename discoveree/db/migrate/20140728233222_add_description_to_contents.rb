class AddDescriptionToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :description, :text
  end
end
