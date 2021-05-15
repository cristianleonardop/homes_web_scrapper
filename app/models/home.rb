class Home < ApplicationRecord
  def self.to_csv
    columns = %w[title address monthly_rent url]

    CSV.generate do |csv|
      csv << columns
      all.find_each do |home|
        csv << home.attributes.values_at(*columns)
      end
    end
  end
end
