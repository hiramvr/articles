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

class Article < ApplicationRecord
    has_one :summary, dependent: :destroy

    validates :title, presence: true
    validates :content, presence: true
    validates :link, presence: true
    validates :created_at, presence: true
    validates :updated_at, presence: true
end
