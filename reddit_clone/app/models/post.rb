# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :content, :subs, presence: true
  
  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User
    
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  
  has_many :subs, 
    through: :post_subs, 
    source: :sub
    
  has_many :comments
  has_many :votes, as: :voteable
  
  def comments_by_parent_id
    comments = self.comments
    # return {} unless comments
    temp = Hash.new { |h,k| h[k] = [] }
    
    comments.each do |comment|
      temp[comment.parent_comment_id] << comment
    end
    temp
  end
  
  def num_votes
    sum = 0
    votes.each do |v|
      v.upvote ? sum += 1 : sum -= 1
    end
    sum
  end

end
