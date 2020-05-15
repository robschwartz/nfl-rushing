class NflController < ApplicationController
  caches_action :show_stats

  def show_stats
    stat = params[:stat]
    @data = NflApiService.pull_stat_data(stat)
    @headers = @data[0].keys
    @sortable_cols = ['Yds', 'Lng', 'TD']
    @searchable_cols = ['Player']
  end
end