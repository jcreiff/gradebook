class Teacher < ActiveRecord::Base

  has_secure_password
  has_many :students
  has_many :assignments

  default_scope {order(:name)}

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

end
