class Grade < ActiveRecord::Base

  belongs_to :student

  default_scope {order(:date)}

  validates :student_id, presence: true
  validates :assignment_name, presence: true
  validates :score, presence: true
  validates :date, presence: true

end
