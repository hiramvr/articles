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

class Collection < ApplicationRecord
    validates :title, presence:true
    validates :name_articles, presence:true
    validates :created_at, presence:true
    validates :updated_at, presence:true
end
