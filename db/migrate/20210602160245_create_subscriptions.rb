class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.integer :status
      t.integer :frequency
      t.references :customers, foreign_key: true
      t.references :teas, foreign_key: true

      t.timestamps
    end
  end
end
