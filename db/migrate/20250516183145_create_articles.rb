class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :link, null: false

      t.datetime :published_at

      t.timestamps
    end
  end
end
