class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string  :cnpj,             limit: 21
      t.string  :name

      t.timestamps
    end

    add_index :accounts, :cnpj
  end
end
