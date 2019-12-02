class AddOwnerToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :ownerId, :bigint
    #add_reference :events, :owner, references: :users, index: true
    add_foreign_key :events, :users, column: :ownerId
  end
end
