# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  content           :string           not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :post
  
  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User
  
  belongs_to :parent_comment,
    optional: :true,
    foreign_key: :parent_comment_id,
    class_name: :Comment
    
  has_many  :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment
  
  has_many :votes, as: :voteable
  
  def num_votes
    sum = 0
    votes.each do |v|
      v.upvote ? sum += 1 : sum -= 1
    end
    sum
  end
    
end
