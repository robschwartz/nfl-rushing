Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'nfl/:stat', to: 'nfl#show_stats', as: 'show_stats'
  post '/download-data', to: 'nfl#download_csv', as: 'download_csv'
end
