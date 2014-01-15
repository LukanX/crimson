class ChangePeriodDateNameConventions < ActiveRecord::Migration
  def change
    remove_column :periods, :startDate, :date
    remove_column :periods, :endDate, :date
    add_column :periods, :start_date, :date
    add_column :periods, :end_date, :date
  end
end
