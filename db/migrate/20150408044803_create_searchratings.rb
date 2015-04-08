class CreateSearchratings < ActiveRecord::Migration
  def change
    create_table :searchratings do |t|
      t.string :name
      t.string :store
      t.string :price
      t.string :country
      t.string :compatibility
      t.string :category
      t.string :updated_date
      t.string :size
      t.string :seller
      t.string :rated
      t.string :requirements
      t.string :bundleid
      t.string :average_current
      t.string :total_current
      t.string :average_all
      t.string :total_all
      t.string :current1
      t.string :current2
      t.string :current3
      t.string :current4
      t.string :current5
      t.string :all1
      t.string :all2
      t.string :all3
      t.string :all4
      t.string :all5

      t.references :search
      t.timestamps
    end
  end
end
