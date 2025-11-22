Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # API routes for Avatar Destekli Dil Öğrenme Uygulaması
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :avatars
  resources :learning_paths
  resources :conversations do
    resources :messages
  end

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path - API info
  root to: proc { [200, {'Content-Type' => 'application/json'}, [{
    api: 'Avatar Destekli Dil Öğrenme Backend API',
    version: '2.0.0',
    endpoints: {
      users: '/users',
      avatars: '/avatars',
      learning_paths: '/learning_paths',
      conversations: '/conversations',
      messages: '/conversations/:conversation_id/messages'
    }
  }.to_json]] }
end
