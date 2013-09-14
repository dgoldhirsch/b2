class AddSuperuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superuser, :boolean
    execute "
      UPDATE users SET superuser = TRUE WHERE superuser IS NULL
    "
  end
end
