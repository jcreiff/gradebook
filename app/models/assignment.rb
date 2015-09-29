class Assignment < ActiveRecord::Base

  belongs_to :teacher
  has_many :grades

  validates :teacher_id, presence: true
  validates :name, presence: true

end
