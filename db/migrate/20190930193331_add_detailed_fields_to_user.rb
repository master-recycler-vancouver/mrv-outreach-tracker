class AddDetailedFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :about_me, :text
    add_column :users, :facebook_handle, :string
    add_column :users, :instagram_handle, :string
    add_column :users, :linkedin_handle, :string
    add_column :users, :twitter_handle, :string
  end
end
