class AddTitleToOutreachEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :outreach_events, :title, :string
  end
end
