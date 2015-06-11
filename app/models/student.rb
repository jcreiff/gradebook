class Student < ActiveRecord::Base

  has_secure_password
  belongs_to :teacher
  has_many :parents
  has_many :grades

  default_scope {order(:name)}

  validates :teacher_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

end
