class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :startDate
      t.datetime :endDate
      t.string :street
      t.string :neighborhood
      t.string :city
      t.string :referencePoint
      t.string :description
      t.boolean :status

      t.timestamps
    end
  end
end
