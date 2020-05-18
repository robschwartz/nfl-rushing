require 'json'
require 'csv'

module NflApiService
  module_function
  
  # Ideally I would use this method to pull data from an outside API. I typically use Faraday
  def pull_stat_data(stat, sort, sort_col, search)
    file = File.read("lib/#{stat}_10k.json")
    stat_hash = JSON.parse(file)
   
    if !search.blank?
      stat_hash = stat_hash.select { |x| x['Player'].downcase.include?(search.downcase)}
      stat_hash
    end
   
    stat_hash.sort_by!{ |k| k[sort_col].is_a?(String)? k[sort_col].delete(",").to_i : k[sort_col] }

    stat_hash.reverse! if sort == "acs"
    
    stat_hash
  end

  def to_csv(data)
    csv_string = CSV.generate(headers: true) do |csv|
      csv << data[0].keys
      data.each do |hash|
        csv << hash.values
      end
    end
  end
end
