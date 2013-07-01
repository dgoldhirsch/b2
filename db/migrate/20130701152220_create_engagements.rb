class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.text :name
      t.integer :customer_id

      t.timestamps
    end
  end
end
