Rails.application.routes.draw do
  resources :birds, only: %i[index show create update]
  # handles the likes
  patch '/birds/:id/like', to: 'birds#increment_likes'
end
