# == Schema Information
#
# Table name: collections
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  name_articles :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "test_helper"

class CollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
