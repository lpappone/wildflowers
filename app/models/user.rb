class User < ApplicationRecord
  before_save { email.downcase! }
  validates(:firstName, presence: true, length: { maximum: 50 })
  validates(:lastName, presence: true, length: { maximum: 50 })
  # From https://www.railstutorial.org/book/modeling_users#cha-6_footnote-ref-11
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false})
  validates(:password, presence: true, length: { minimum: 6 })
  has_secure_password
end
