class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :account_id
      t.integer :user_id
      t.integer :topic_id
      t.text :message

      t.timestamps
    end

    add_index :posts, :topic_id
  end
end
