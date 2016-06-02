### User Controller

1. Generate a Users Controller
          rails generate controller Users
2. Add corresponding routes
              resources :users, only: [:create, :new] #Users controller #2

            Gives you :
            Prefix Verb   URI Pattern            Controller#Action
            users     POST   /users(.:format)       users#create
            new_user  GET    /users/new(.:format)   users#new
            
3. dsfsdf
