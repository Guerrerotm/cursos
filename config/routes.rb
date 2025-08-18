Rails.application.routes.draw do
  resources :cursos
  get 'vista-alumnos', to: 'cursos#vista_alumnos'
get 'vista-alumnos/:id', to: 'cursos#vista_alumnos', as: 'vista_alumno'
get 'cursos-alumnos', to: 'cursos#cursos_alumnos', as: 'alumnos'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'cursos-alumnos', to: 'cursos#cursos_alumnos'

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

