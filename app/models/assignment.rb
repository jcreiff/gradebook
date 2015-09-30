class Assignment < ActiveRecord::Base

  belongs_to :teacher
  has_many :grades

  validates :teacher_id, presence: true
  validates :name, presence: true

  accepts_nested_attributes_for :grades, allow_destroy: true, reject_if: :all_blank

end
