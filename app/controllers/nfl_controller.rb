class NflController < ApplicationController
  # caches_action :show_stats
    before_action :set_cache
    before_action :set_stat
    before_action :set_data

  def show_stats
    puts 'show stats-----'

    @headers = @data[0].keys
    @sortable_cols = ['Yds', 'Lng', 'TD']
    @searchable_cols = ['Player']
  end

  private
  
  def all_cache
    puts 'Set cached data'
    @cache.write('stat_data', stat_data(@stat))
    puts @cache.exist?('stat_data')
  end

  def stat_data(stat)
    puts 'Pull stat data'
    NflApiService.pull_stat_data(stat)
  end

  def set_stat
    puts 'Set stat'
    @stat = params[:stat]
  end

  def set_data
    puts 'Set data'
    puts @cache.exist?('stat_data')
    if !@cache.exist?('stat_data')
      all_cache
    end

    @data = @cache.read('stat_data')
  end

  def set_cache
    @cache ||= ActiveSupport::Cache::MemoryStore.new
  end
end