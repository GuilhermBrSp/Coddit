class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.references :tag
      t.timestamps
    end
  end
end
