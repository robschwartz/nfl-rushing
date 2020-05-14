require 'json'

module NflApiService
  module_function
  
  # Ideally I would use this method to pull data from an outside API. I typically use Faraday
  def pull_stat_data(stat)
    file = File.read("lib/#{stat}_10k.json")
    stat_hash = JSON.parse(file)
  end
end
