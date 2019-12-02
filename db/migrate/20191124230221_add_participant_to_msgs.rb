class AddParticipantToMsgs < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :msgs, :participants, column: :participantId
  end
end
