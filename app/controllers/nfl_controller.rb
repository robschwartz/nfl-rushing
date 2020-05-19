# Controller to handle NFL routing
class NflController < ApplicationController
  include Pagy::Backend
  before_action :set_data

  def show_stats
    @pagy, @data = pagy_array(@data) if @data
    @headers = @data[0].keys if @data
    @sortable_cols = %w[Yds Lng TD]
    @searchable_cols = ['Player']
  end

  def download_csv
    send_data NflApiService.to_csv(@data), filename: "player-#{Time.zone.today}.csv", disposition: 'attachment'
  end

  private

  def set_data
    @data = NflApiService.pull_stat_data(set_stat, set_sort, set_sort_col, set_search)
  end

  def set_stat
    @stat = params[:stat]
  end

  def set_sort
    @sort = params[:sort]
  end

  def set_sort_col
    @sort_col = params[:sort_col]
  end

  def set_search
    @search = params[:search]
  end
end
