# == Schema Information
#
# Table name: summaries
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  content     :string           not null
#  source_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :integer          not null
#
# Indexes
#
#  index_summaries_on_article_id  (article_id)
#

require "test_helper"

class SummaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
