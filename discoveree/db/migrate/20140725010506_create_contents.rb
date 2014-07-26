class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :url
      t.string :source
      t.references :user
      t.references :category

      t.timestamps
    end
  end
end
