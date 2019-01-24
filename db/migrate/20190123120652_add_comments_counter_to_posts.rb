class AddCommentsCounterToPosts < ActiveRecord::Migration[5.1]
  def change
    change_table :posts do |t|
       t.integer :comments_counter
    end
  end
end
