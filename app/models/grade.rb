class Grade < ActiveRecord::Base

  belongs_to :student
  belongs_to :assignment

  validates :student_id, presence: true
  validates :assignment_id, presence: true
  validates :score, presence: true

end
