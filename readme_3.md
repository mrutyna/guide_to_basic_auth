### Session Controller

1. Generate a Sessions Controller
          rails generate controller Sessions
2. Sessions are a singular resource so in the routes table, as opposed to resources, you would add them as a 'resource' singular, and you only need new, create, and destroy, where new generates the form to log in, create, creates the actual session in sending back the form data, and destroy coresponds to a user logging out.
            resource :session, only: [:create, :destroy, :new] #sessions controller #2

            Gives you :
            Prefix Verb   URI Pattern            Controller#Action
            session     POST   /session(.:format)     sessions#create
            new_session GET    /session/new(.:format) sessions#new
                        DELETE /session(.:format)     sessions#destroy
3. We already wrote the log out logic in Application controller #5, since this is the easiest to implement, start with destroy logic on sessions.
      def destroy #3
        logout_user!
        redirect_to new_session_url
      end
4. The new method only pulls up the new view, so this is as easy as
          def new #4
            render :new
          end

5. Now writing the create method which receives the post command on session_url- It should find a user based on parameters, if that succeeds, then login the user, setting the session token using the helper method, or if it fails, we wnat to flash an error and re_render the new page so they can try putting in the info again.
          def create #5
            user = User.find_by_credentials(
              params[:user][:username],
              params[:user][:password]
              )

            if user.nil?
              flash.now[:errors] = ["Incorrect username and/or password"]
              render :new
            else
              login_user!(user)
              redirect_to root_url
            end
          end

6. Git Commit 10- SessionsController Complete
        GIT COMMIT 10- Session Controller Complete
