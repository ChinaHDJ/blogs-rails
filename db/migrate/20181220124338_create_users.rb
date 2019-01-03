class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :avatar_url
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :is_deleted
      t.datetime :deleted_at
      t.integer :permission
      t.timestamps
    end
  end
end
