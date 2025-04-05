class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
