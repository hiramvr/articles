class AddArticleReferenceToSummaries < ActiveRecord::Migration[8.0]
  def change
    add_references :summaries, :article, null:false, foreign_key: true
  end
end
