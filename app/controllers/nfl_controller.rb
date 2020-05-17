class NflController < ApplicationController
  include Pagy::Backend

  def show_stats
    @stat = params[:stat]
    @sort = params[:sort]
    @sort_col = params[:sort_col]
    @page = params[:page]
    puts Time.now
    @data = NflApiService.pull_stat_data(@stat, @sort, @sort_col, @search)
    @pagy, @data = pagy_array(@data)
    puts Time.now
    @headers = @data[0].keys
    @sortable_cols = ['Yds', 'Lng', 'TD']
    @searchable_cols = ['Player']
  end
end