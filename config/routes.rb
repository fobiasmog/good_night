Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index]

      resources :sleep_records, only: %i[index]
      resource :sleep_record, only: %i[create update]
    end
  end
end
