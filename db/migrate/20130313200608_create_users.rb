class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :role
      t.string :persistence_token
      t.string :single_access_token
      t.string :perishable_token

      t.timestamps
    end
  end
end
