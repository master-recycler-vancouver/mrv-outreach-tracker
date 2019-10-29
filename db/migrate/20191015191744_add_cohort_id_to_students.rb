class AddCohortIdToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :cohort, index: true, foreign_key: true
  end
end
