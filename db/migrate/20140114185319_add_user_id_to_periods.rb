class AddUserIdToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :user_id, :integer
  end
end
