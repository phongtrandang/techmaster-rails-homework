class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :address
      t.date :created
      t.string :balance

      t.timestamps
    end
  end
end
