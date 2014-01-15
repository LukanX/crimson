class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :startDate
      t.date :endDate

      t.timestamps
    end
  end
end
