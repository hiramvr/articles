# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  content      :string           not null
#  link         :string           not null
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
