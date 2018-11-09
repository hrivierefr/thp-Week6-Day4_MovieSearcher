Rails.application.routes.draw do
  	get '/', to: 'movies#index', as: 'root'
  	get '/:movie_request', to: 'movies#index', as: 'movie_search'
	patch '/', to: 'movies#update'
end