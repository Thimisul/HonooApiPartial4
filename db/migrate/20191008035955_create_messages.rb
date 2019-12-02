class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.datetime :date
      t.string :message

      t.timestamps
    end
  end
end
