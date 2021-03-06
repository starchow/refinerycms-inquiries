Refinery::Core::Engine.routes.draw do
  namespace :inquiries, :path => '' do
    get '/support', :to => 'inquiries#new', :as => 'new_inquiry'

    resources :support,
                :only => :create,
                :as => :inquiries,
                :controller => 'inquiries' do
      get :thank_you, :on => :collection
    end

    namespace :admin, :path => Refinery::Core.backend_route do
      resources :inquiries, :only => [:index, :show, :destroy] do
        get :spam, :on => :collection
        get :toggle_spam, :on => :member
      end

      scope :path => 'inquiries' do
        resources :settings, :only => [:edit, :update]
      end
    end
  end
end
