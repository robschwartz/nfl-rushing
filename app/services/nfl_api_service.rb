require 'json'

module NflApiService
  module_function
  
  # Ideally I would use this method to pull data from an outside API. I typically use Faraday
  def pull_stat_data(stat, sort, sort_col, search)
    file = File.read("lib/#{stat}_10k.json")
    stat_hash = JSON.parse(file)

    stat_hash.sort_by!{ |k| k[sort_col].is_a?(String)? k[sort_col].delete(",").to_i : k[sort_col] }

    if sort == "acs"
      stat_hash.reverse!
    end
    stat_hash
  end
end
