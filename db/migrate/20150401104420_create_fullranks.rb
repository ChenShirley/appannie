class CreateFullranks < ActiveRecord::Migration
  def change
    create_table :fullranks do |t|
      t.string :apptype
      t.integer :rank
      t.string :name
      t.text :link
      t.timestamps
    end
  end
end
