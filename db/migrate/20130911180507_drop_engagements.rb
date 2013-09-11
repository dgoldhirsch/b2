class DropEngagements < ActiveRecord::Migration
  def up
    drop_table :engagements
  end

  def down
    # See migration 20130701152220_create_engagements.rb
    create_table :engagements do |t|
      t.text :name
      t.integer :customer_id

      t.timestamps
    end
  end
end
