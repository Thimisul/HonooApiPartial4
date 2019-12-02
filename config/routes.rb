Rails.application.routes.draw do
 
  resources :msgs
  #  resources :messages
  
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    get 'tipoEvento', to: 'event_types#getEventType'
  
    post 'user', to: 'users#addUser'
    put 'user', to: 'users#update'
    get 'user/:id', to: 'users#show'
    delete 'user/:id', to: 'users#destroy'
    post 'user/login', to: 'users#login'
    # get 'users' to: 'users#getUser'
  
    post 'event', to: 'events#addEvent'
    put 'event', to: 'events#updateEvent'
    get 'event', to: 'events#getEvent'
    get 'event/search', to: 'events#searchEvent'
    get 'event/:id', to: 'events#getEventById'
    delete 'event/:id', to: 'events#destroy'
  
    post 'participant', to: 'participants#create'
    get 'participant/:id', to: 'participants#show'
    delete 'participant/:id', to: 'participants#destroy'
   
    post 'mensagem', to: 'msgs#create'
    put 'mensagem', to: 'msgs#update'
    get 'mensagem/:id', to: 'msgs#show'
    delete 'event/:id', to: 'msgs#destroy'

    get 'mensagem/evento/:id', to: 'events#getMensagens'
    
  
  end
  
