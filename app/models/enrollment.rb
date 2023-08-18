class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  belongs_to :program
end
