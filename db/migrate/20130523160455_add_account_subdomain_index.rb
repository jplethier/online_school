class AddAccountSubdomainIndex < ActiveRecord::Migration
  def change
    add_index :accounts, :subdomain
  end
end
