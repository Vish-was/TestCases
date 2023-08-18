# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Show Users' do
  let!(:user_1) { User.create(kind: "Student", name: 'Student 1', age: 21) }
  let!(:user_2) { User.create(kind: "Teacher", name: 'Teacher 2', age: 22) }
  let!(:user_3) { User.create(kind: "Student", name: 'Student 3', age: 22) }
  let!(:user_4) { User.create(kind: "Teacher", name: 'Teacher 4', age: 23) }
  let!(:teacher_1) { Teacher.create(kind: "Teacher", name: 'Teacher 1', age: 50, user_id: user_1.id) }
  let!(:teacher_2) { User.create(kind: "Teacher", name: 'Teacher 2', age: 60) }
  let!(:teacher_3) { User.create(kind: "Teacher", name: 'Teacher 3', age: 60) }
  let!(:teacher_student) { User.create(kind: 2, name: 'Student and Teacher', age: 40) }
  let!(:program_1) { Program.create(name: 'AI is going to destroy the world') }
  let!(:program_2) { Program.create(name: 'Wall Street for dummies') }
  let!(:program_3) { Program.create(name: 'How to be a millionaire') }
  let!(:program_4) { Program.create(name: 'How to be a millionaire or get rich trying') }
  let!(:enrollment_1) { Enrollment.create(user: user_1, teacher: teacher_1, program: program_1) }
  let!(:enrollment_2) do
    Enrollment.create(user: user_2, teacher: teacher_1, program: program_1, favorite: true)
  end
  let!(:enrollment_3) { Enrollment.create(user: user_2, teacher: teacher_1, program: program_1) }
  let!(:enrollment_4) { Enrollment.create(user: user_2, teacher: teacher_1, program: program_2) }
  let!(:enrollment_5) do
    Enrollment.create(user: user_2, teacher: teacher_1, program: program_2, favorite: true)
  end
  let!(:enrollment_6) { Enrollment.create(user: user_2, teacher: teacher_1, program: program_3) }
  let!(:enrollment_7) { Enrollment.create(user: user_2, teacher: teacher_1, program: program_3) }
  let!(:enrollment_8) { Enrollment.create(user: user_1, teacher: teacher_1, program: program_3) }

  feature 'Validation errors' do
    context 'kind related errors' do
      scenario 'when a teacher wants to be set a student' do
        visit edit_user_path(user_2)

        select('Student', from: "user_kind", match: :first)
        click_on 'Update User'

        expect(page).to have_text("Kind can not be student because is teaching in at least one program")
        user_2.reload
      end

      scenario 'when a student wants to be set as a teacher' do
        visit edit_user_path(user_1)

        select('Teacher', from: "user_kind", match: :first)
        click_on 'Update User'

        expect(page).to have_text("Kind can not be teacher because is studying in at least one program")
        user_1.reload
      end
    end
  end

  feature 'Validation ok' do
    scenario 'when a teacher wants to be set a student' do
      visit edit_user_path(user_4)

      select('Student', from: 'user_kind', match: :first)
      click_button 'Update User'

      expect(page).not_to have_text("Kind can not be student because is teaching in at least one program")
      user_2.reload
      expect(user_2.kind) == ('Student')
    end

    scenario 'when a student wants to be set as a teacher' do
      visit edit_user_path(user_3)

      select('Teacher', from: "user_kind", match: :first)
      click_button 'Update User'
      expect(page).not_to have_text("Kind can not be teacher because is studying in at least one program")
      user_3.reload
      expect(user_3.kind) == ('Teacher')
    end
  end
end
