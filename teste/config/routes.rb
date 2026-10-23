Teste::Application.routes.draw do

  get "hello" => "hello#index"

  get    "/produtos"     => "produtos#index"
  get    "/produtos/novo" => "produtos#new"
  get    "/produtos/:id" => "produtos#show"
  post   "/produtos"     => "produtos#create"
  put    "/produtos/:id" => "produtos#update"
  delete "/produtos/:id" => "produtos#destroy"
  get "/produtos/:id/editar" => "produtos#edit"
  put "/produtos/:id" => "produtos#update"

  root to: "login#index"
  prefixo = "/agenda"

  get "#{prefixo}" => "paginas#index", :as => :agenda
  
  get  "#{prefixo}/login"  => "login#index", as: "login"
  post "#{prefixo}/login"  => "login#create"
  get  "#{prefixo}/logout" => "login#destroy", as: "logout"

  # Usuario
  get    "#{prefixo}/usuarios"          => "usuarios#index",   :as => :usuarios
  post   "#{prefixo}/usuarios"          => "usuarios#create"
  get    "#{prefixo}/usuarios/new"      => "usuarios#new",     :as => :new_usuario
  get    "#{prefixo}/usuarios/:id/edit" => "usuarios#edit",    :as => :edit_usuario
  get    "#{prefixo}/usuarios/:id"      => "usuarios#show",    :as => :usuario
  put    "#{prefixo}/usuarios/:id"      => "usuarios#update"
  delete "#{prefixo}/usuarios/:id"      => "usuarios#destroy"

  get "#{prefixo}/muda_senha" => "usuarios#muda_senha", :as => :muda_senha
  put "#{prefixo}/muda_senha" => "usuarios#atualiza_senha"

  # Contato
  get    "#{prefixo}/contatos"          => "contatos#index",   :as => :contatos
  post   "#{prefixo}/contatos"          => "contatos#create"
  get    "#{prefixo}/contatos/new"      => "contatos#new",     :as => :new_contato
  get    "#{prefixo}/contatos/:id/edit" => "contatos#edit",    :as => :edit_contato
  get    "#{prefixo}/contatos/:id"      => "contatos#show",    :as => :contato
  put    "#{prefixo}/contatos/:id"      => "contatos#update"
  delete "#{prefixo}/contatos/:id"      => "contatos#destroy"

  # Telefone
  get    "#{prefixo}/telefones"          => "telefones#index",   :as => :telefones
  post   "#{prefixo}/telefones"          => "telefones#create"
  get    "#{prefixo}/telefones/new"      => "telefones#new",     :as => :new_telefone
  get    "#{prefixo}/telefones/:id/edit" => "telefones#edit",    :as => :edit_telefone
  get    "#{prefixo}/telefones/:id"      => "telefones#show",    :as => :telefone
  put    "#{prefixo}/telefones/:id"      => "telefones#update"
  delete "#{prefixo}/telefones/:id"      => "telefones#destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
