class AddEventTypeToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :eventTypeId, :bigint
    add_foreign_key :events, :event_types, column: :eventTypeId
  end
end
