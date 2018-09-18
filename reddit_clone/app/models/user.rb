# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  after_initialize :ensure_session_token
  
  validates :session_token, :password_digest, :username, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  attr_reader :password
  
  has_many :moderated_subs,
    foreign_key: :moderator_id,
    class_name: :Sub
    
  has_many :posts_authored,
    foreign_key: :author_id,
    class_name: :Post
    
  has_many :comments_written,
    foreign_key: :author_id,
    class_name: :Comment
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
end
