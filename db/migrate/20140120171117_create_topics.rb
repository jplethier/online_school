class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :classroom_id
      t.integer :user_id
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
