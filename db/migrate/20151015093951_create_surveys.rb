class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :esearch
      t.string :regulatoryfocus
      t.string :age
      t.integer :gender
      t.integer :income
      t.integer :involvement1
      t.integer :involvement2
      t.integer :involvement3
      t.integer :rf1
      t.integer :rf2
      t.integer :rf3
      t.integer :rf4
      t.integer :rf5
      t.integer :rf6
      t.integer :rf7
      t.datetime :endtime

      t.timestamps
    end
  end
end
