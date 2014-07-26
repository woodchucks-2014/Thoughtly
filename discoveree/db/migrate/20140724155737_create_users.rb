class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email
      t.string :uid
      t.string :refresh_token
      t.string :access_token
      t.string :expires
      
      t.timestamps
    end
  end

end
