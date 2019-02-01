class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :post, foreign_key: true
      t.integer :token_id

      t.timestamps
    end
  end
end
