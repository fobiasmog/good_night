Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index]

      resources :sleep_records, only: %i[index]
      resource :sleep_record, only: %i[create update]

      resources :user_friends, only: %i[index create destroy] do
        get :sleep_records, to: 'user_friends#sleep_records', on: :collection
      end
    end
  end
end
