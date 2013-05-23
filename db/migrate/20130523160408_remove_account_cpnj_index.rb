class RemoveAccountCpnjIndex < ActiveRecord::Migration
  def change
    remove_index :accounts, :cnpj
  end
end
