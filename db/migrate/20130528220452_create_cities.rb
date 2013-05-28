class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :uf, limit: 2

      t.timestamps
    end

    add_index :cities, :uf
  end
end
