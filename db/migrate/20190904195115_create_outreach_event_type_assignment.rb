class CreateOutreachEventTypeAssignment < ActiveRecord::Migration[5.2]
  def change
    create_table :outreach_event_type_assignments do |t|
      t.belongs_to :outreach_event
      t.belongs_to :outreach_event_type

      t.timestamps
    end
  end
end
