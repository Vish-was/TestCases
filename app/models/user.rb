class User < ApplicationRecord
  has_many :teachers
  has_many :enrollments
  def student?
    kind == 'Student'
  end

  def teacher?
    kind == 'Teacher'
  end
end
