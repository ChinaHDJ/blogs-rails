class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :access_token
      t.datetime :expire_at
      t.timestamps
    end
  end
end
