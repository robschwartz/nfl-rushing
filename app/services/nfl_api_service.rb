require 'json'
require 'csv'

module NflApiService
  module_function

  # Ideally I would use this method to pull data from an outside API. I typically use Faraday
  def pull_stat_data(stat, sort, sort_col, search)
    file = File.read("lib/#{stat}_10k.json")
    stat_hash = JSON.parse(file)

    # If user searches by player name, select all data that matches search input
    if search.present?
      stat_hash = stat_hash.select { |x| x['Player'].downcase.include?(search.downcase) }
    end

    # Sort data based on user's sort selections
    sort_data(stat_hash, sort, sort_col)
    
  rescue StandardError => e
    puts e
  end

  def sort_data(stat_hash, sort, sort_col)
    # Sort data based on column chosen
    stat_hash.sort_by! { |k| k[sort_col].is_a?(String) ? k[sort_col].delete(',').to_i : k[sort_col] }

    # Sort by asc or desc
    stat_hash.reverse! if sort == 'desc'

    # retrun sorted data
    stat_hash
  end

  # Convert data to CSV format for download
  def to_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << data[0].keys
      data.each do |hash|
        csv << hash.values
      end
    end
  rescue StandardError => e
    puts e
  end
end
