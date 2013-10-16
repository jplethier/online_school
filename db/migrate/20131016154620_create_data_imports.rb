class CreateDataImports < ActiveRecord::Migration
  def change
    create_table :data_imports do |t|
      t.string     :data_type
      t.integer    :processed, default: 0
      t.integer    :total
      t.references :account
      t.timestamps
    end

    add_attachment :data_imports, :file
  end
end
