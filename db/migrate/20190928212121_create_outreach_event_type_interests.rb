class CreateOutreachEventTypeInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :outreach_event_type_interests do |t|
      t.belongs_to :outreach_event_type
      t.belongs_to :user

      t.timestamps
    end
  end
end
