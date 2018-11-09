Rails.application.routes.draw do
  get '/', to: 'movies#search', as: 'root'
end
