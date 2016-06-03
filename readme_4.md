### User Controller

-1. Generate a Users Controller
```ruby
          rails generate controller Users
```          
-2. Add corresponding routes
```ruby
              resources :users, only: [:create, :new] #Users controller #2
```
```
            Gives you :
            Prefix Verb   URI Pattern            Controller#Action
            users     POST   /users(.:format)       users#create
            new_user  GET    /users/new(.:format)   users#new
```
-3. Rails uses strong Params so you need to permit the user to be able to send in their username and password
```ruby
          private #3

          def user_params #3
            params.require(:user).permit(:password, :username)
          end
```
-4. A new user request should render the signup page.
```ruby
          def new #4
            @user = User.new
            render :new
          end
```

-5. Finally add a create action that takes in the submitted paramaters from the form, if it successfully saves, then you can log in the user and redirect them to the root_url. If not you should give them their errors and re-render the signup page.
```ruby
        def create #5
          @user = User.new(user_params)
          if @user.save
            login_user!(@user)
            redirect_to root_url
          else
            flash.now[:errors] = @user.errors.full_messages
            render :new
          end
        end
```
-6. This is what it should look like:
```ruby
        class UsersController < ApplicationController

          def new #4
            @user = User.new
            render :new
          end

          def create #5
            @user = User.new(user_params)
            if @user.save
              login_user!(@user)
              redirect_to root_url
            else
              flash.now[:errors] = @user.errors.full_messages
              render :new
            end
          end

          private #3

          def user_params #3
            params.require(:user).permit(:password, :username)
          end
        end

```
7. Git Commit 12- User Controller Complete
```
        GIT COMMIT 12- User Controller Complete
```
