class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.string :name
      t.date :issue_date
      t.date :service_date
      t.integer :total_charge
    end
  end
end
