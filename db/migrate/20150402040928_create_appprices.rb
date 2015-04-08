class CreateAppprices < ActiveRecord::Migration
  def change
    create_table :appprices do |t|
      t.string :name
      t.string :store
      t.string :price

      t.references :fullrank
      t.timestamps
    end
  end
end
