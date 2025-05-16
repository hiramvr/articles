class CreateSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :summaries do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :source_type, null: false
      

      t.timestamps
    end
  end
end
