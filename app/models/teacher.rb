class Teacher < ActiveRecord::Base

  has_secure_password
  has_many :students, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end
