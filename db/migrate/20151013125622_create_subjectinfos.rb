class CreateSubjectinfos < ActiveRecord::Migration
  def change
    create_table :subjectinfos do |t|
      t.string :esearch
      t.string :regulatoryfocus
      t.integer :mobile_user
      t.integer :appstore
      t.integer :visit_frequency
      t.integer :app_expense
      t.integer :previous_experience
      t.string :ipaddress
      t.datetime :starttime

      t.timestamps
    end
  end
end
