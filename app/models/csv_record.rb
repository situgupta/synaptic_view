class CsvRecord < ApplicationRecord
    belongs_to :user

    def self.import(file,current_user)
        CSV.foreach(file.path, headers: true)do |row|
            current_user.csv_records.find_or_create_by row.to_hash
        end
    end

    def self.to_csv
        attributes = %w{date value domain_name}
        CSV.generate(headers: true) do |csv|
            csv<< attributes
            all.each do |row|
                p"#{row}"
                csv << attributes.map{|attr| row.send(attr)}
            end
        end
    end

    def self.max_value(csv_records)
        max_value = csv_records.pluck(:value).max()
        
    end

    def self.time_series(params)
        CSVRecords.where(date: from_date..to_date)
    end
end
