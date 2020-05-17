require 'json'

module NflApiService
  module_function
  
  # Ideally I would use this method to pull data from an outside API. I typically use Faraday
  def pull_stat_data(stat, sort, sort_col, search)
    file = File.read("lib/#{stat}.json")
    stat_hash = JSON.parse(file)
    if !search.blank?
      stat_hash = stat_hash.select { |x| x['Player'].downcase.include?(search.downcase)}
      puts [stat_hash]
    else
      stat_hash.sort_by!{ |k| k[sort_col].is_a?(String)? k[sort_col].delete(",").to_i : k[sort_col] }

      stat_hash.reverse! if sort == "acs"
    end
    stat_hash
  end
end
