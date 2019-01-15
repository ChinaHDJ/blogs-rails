class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.bigint :user_id
      t.string :desc
      t.string :title
      t.string :tag
      t.text :content
      t.timestamps
    end
  end
end
