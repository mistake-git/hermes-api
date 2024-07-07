Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/:provider/callback', to: 'sessions#create'
      resources :companies do
        collection do
          get 'search'
        end
      end

      resources :homes, only: [:index] do
        collection do
          get 'interviews', to: 'homes#interviews'
          get 'job_application_todos', to: 'homes#job_application_todos'
        end
      end
      resources :job_applications
      resources :interviews
      resources :job_application_todos
    end
  end
end
