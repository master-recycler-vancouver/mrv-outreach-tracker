class CreateCollaborations < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :outreach_event, index: true

      t.timestamps
    end
  end
end
