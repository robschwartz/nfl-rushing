class NflController < ApplicationController
  include Pagy::Backend

  def show_stats
    stat = params[:stat]
    @pagy, @data = pagy_array(NflApiService.pull_stat_data(stat), items: 20)
    @headers = @data[0].keys
    @sortable_cols = ['Yds', 'Lng', 'TD']
    @searchable_cols = ['Player']
  end
end