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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
