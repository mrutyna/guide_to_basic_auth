### Application Controller

-1. Now we should be building a User Controller and a SessionsController, but since helper methods in Application controller make it easier to write the other 2, lets start with the application controller, since it provides helper methods for the other two. Also the hw makes you refactor stuff out of session controller and move it into application controller. So lets save time and go straight to where the code should be.

-2. Defining what the current_user is, as well as adding a helper method to make it available to all the views. It is trying to fins a user based on matching the session token. NOTE ALL METHODS are private.
```ruby
        private #2

        helper_method :current_user #2

        def current_user #2
          return nil unless session[:session_token]
          @current_user ||= User.find_by_session_token(session[:session_token])
        end
```
-3. Define logged_in? as the opposite of current_user, returning a boolean.
```ruby
        helper_method :logged_in? #3

        def logged_in? #3
          !current_user.nil?
        end
```
-4. Define Login User, which, (assuming you were able to find the user using their credentials), will reset their session token to a new token for extra security, and set the cookie in the session hash.
```ruby
          def login_user!(user) #4
            session[:session_token] = user.reset_session_token!
          end
```

-5. Define Log_out, which will reset the session token in the database, so that even if someone has the old token, it wont work. Simultaneously, it will set the session token in cookie to nil.
```ruby
        def logout_user! #5
          current_user.reset_session_token!
          session[:session_token] = nil
        end
```
-6. FInally, you can add a method for require_user, which will redirect them to signing in, if they arn't logged in.  (note you can also add an optional require no user)
```ruby
        def require_user! #6
          redirect_to new_session_url if current_user.nil?
        end
```
-7. I think the best way to think about these is in pairs,
```
        current_user and logged_in?
        login_user! and logout_user!
        require_user! and the require_no_user! I didnt use
```
-8. Application controller Complete. Here it is:
```ruby
          class ApplicationController < ActionController::Base
            # Prevent CSRF attacks by raising an exception.
            # For APIs, you may want to use :null_session instead.
            protect_from_forgery with: :exception

            helper_method :current_user #2
            helper_method :logged_in? #3

            private #2

            def current_user #2
              return nil unless session[:session_token]
              @current_user ||= User.find_by_session_token(session[:session_token])
            end

            def logged_in? #3
              !current_user.nil?
            end

            def login_user!(user) #4
              session[:session_token] = user.reset_session_token!
            end

            def logout_user! #5
              current_user.reset_session_token!
              session[:session_token] = nil
            end

            def require_user! #6
              redirect_to new_session_url if current_user.nil?
            end
          end
```
-9. Git Commit 8 - Finished ApplicationController
```
          GIT COMMIT 8: Finished ApplicationController- current_user, logged_in, login_user, logout_user, require_user
```
-10. Decided I needed require no user which will redirect to the main page if you are trying to access the log in page but are alreaady logged in (NB: (note that I have it set as a redirect to root_url so its as generic as possible. ))
```ruby
          def require_no_user! #10
            redirect_to root_url if current_user
          end
```
-11. Git Commit 9 -Added require_no_user to new_session_page.
```
          GIT COMMIT 9 - "require_no_user is last pair for ApplicationController"
```

-12. How to use the defined function. You place
  ```before_action :require_user!``` on the pages (particularly root controller) where you dont wnat people to access it unless they are logged in.

-13. While you place ``` before_action :require_no_user!, only: [:create, :new]``` on places like the session and user controllers, where there is no point for a user to make a new user, or sign in, if they are already signed in. 
