class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :apptype
      t.integer :rank
      t.string :name
      t.text :link
      t.timestamps
    end
  end
end
