# == Schema Information
#
# Table name: votes
#
#  id            :bigint(8)        not null, primary key
#  upvote        :boolean
#  voteable_type :string
#  voteable_id   :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#

class Vote < ApplicationRecord
  # validates :upvote, presence: true
  # validates :voteable_id, uniqueness: {scope: :user_id, message: 'User can only vote once.'}
  belongs_to :voteable, polymorphic: true
end
