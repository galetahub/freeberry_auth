Rails.application.routes.draw do
  scope :module => 'freeberry_auth' do
    post '/auth/:provider', :to => 'accounts#create', :as => :auth_provider
    get '/auth/logout', :to => 'accounts#destroy', :as => :auth_logout
  end
end
