class CreateCsvRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_records do |t|
      t.date :date 
      t.string :value
      t.string :domain_name
      t.string :file_name
      t.references :user, null: false, index: true, foreign_key: true
    
      t.timestamps
    end
  end
end
