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
#

class Summary < ApplicationRecord
    belongs_to :article

    validates :title, presence:true
    validates :content, presence:true
    validates :source_type, presence:true
    validates :created_at, presence:true
    validates :updated_at, presence:true
end
