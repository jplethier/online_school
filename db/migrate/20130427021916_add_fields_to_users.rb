class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name,               :string
    add_column :users, :enrollment,         :string
    add_column :users, :phone_number,       :string
    add_column :users, :cellphone_number,   :string
    add_column :users, :birth_date,         :date
    add_column :users, :address,            :string
    add_column :users, :address_number,     :string
    add_column :users, :address_complement, :string
    add_column :users, :address_city,       :string
    add_column :users, :address_state,      :string
  end
end
