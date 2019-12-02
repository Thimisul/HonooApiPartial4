class AddidToParticipant < ActiveRecord::Migration[5.2]
  def change

  
    add_column :messages, :participantId, :bigint
    add_foreign_key :messages, :participants, column: :participantId

    


  end
end
