class AddUserToParticipant < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :userId, :bigint
    add_column :participants, :eventoId, :bigint

    add_foreign_key :participants, :users, column: :userId
    add_foreign_key :participants, :events, column: :eventoId

    remove_column :participants, :user_id
    remove_column :participants, :event_id
  end
end
