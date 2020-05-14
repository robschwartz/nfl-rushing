class NflController < ApplicationController
  def show_stats
    @data = NflApiService.pull_stat_data(stat)
    @headers = @data[0].keys
  end
end