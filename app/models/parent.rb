class Parent < ActiveRecord::Base

  has_secure_password
  belongs_to :student

  validates :student_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

end
