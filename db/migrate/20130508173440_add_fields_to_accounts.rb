class AddFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :contact_mail, :string
    add_column :accounts, :subdomain,    :string
  end
end
