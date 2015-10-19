class CreateRealapps < ActiveRecord::Migration
  def change
    create_table :realapps do |t|
      t.text :link
      t.string :name
      t.text :icon
      t.string :store
      t.string :price
      t.text :description
      t.string :country

      t.float :average_current
      t.integer :total_current
      t.float :average_all
      t.integer :total_all
      t.integer :current1
      t.integer :current2
      t.integer :current3
      t.integer :current4
      t.integer :current5
      t.integer :all1
      t.integer :all2
      t.integer :all3
      t.integer :all4
      t.integer :all5
      t.string :distribution
									
      t.string :compatibility
      t.string :category
      t.string :updated_date
      t.string :size
      t.string :seller
      t.string :rated
      t.string :requirements
      t.string :bundleid

			t.text :screenshot1
			t.text :screenshot2
			t.text :screenshot3
			t.text :screenshot4
			t.text :screenshot5

      t.timestamps
    end
  end
end
