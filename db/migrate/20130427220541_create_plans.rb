class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string  :title

      t.timestamps
    end
  end
end
