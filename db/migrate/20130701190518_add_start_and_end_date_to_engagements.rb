class AddStartAndEndDateToEngagements < ActiveRecord::Migration
  def up
    add_column :engagements, :start_date, :date
    add_column :engagements, :end_date, :date
    
    execute <<-SQL
      UPDATE engagements
      SET start_date = '2012-01-01'
      WHERE start_date IS NULL
    SQL
  end
  
  def down
    remove_column :engagements, :end_date
    remove_column :engagements, :start_date
  end
end
