class CreateOutreachEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :outreach_event_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
