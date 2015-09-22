class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :whole
      t.timestamps
    end
  end
end
