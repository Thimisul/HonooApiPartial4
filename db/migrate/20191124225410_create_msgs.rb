class CreateMsgs < ActiveRecord::Migration[5.2]
  def change
    create_table :msgs do |t|
      t.string :message
      t.datetime :date
      t.bigint :participantId

      t.timestamps
    end
  end
end
