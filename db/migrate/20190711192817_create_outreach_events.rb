class CreateOutreachEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :outreach_events do |t|
    	t.timestamps
    	t.datetime		:start_time, null: false
    	t.datetime		:end_time, null: false
    	t.text			:description, null: false
    	t.integer		:duration_in_minutes, null: false
    	t.integer		:people_reached, null: false
    	t.text			:notes
    end

    add_reference :outreach_events, :user, index: true
    add_foreign_key :outreach_events, :users
  end
end
