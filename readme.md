Basic Authentication Summary

-1. Basic Setup and User Model - [Readme1](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_1.md)

    1. Generate Model for User
    2. Add database level constraints to migration, as well as indices to session_token and username
    3. Add matching validations in model
        * password_digest with message
    4. Set User#password= and User#is_password? (remember to set @password)
    5. Validate Password and add attr_reader
    6. Generate Session_token Codes
        * generate_session_token
        * reset_session_token!
        * ensure_session_token
        * after_initialize :ensure_session_token
    7. User::find_by_credentials


-2. ApplicationController - [Readme2](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_2.md)

  These methods are built as a series of 3 pairs. (all Private)
      1. The two helper_methods
          * current_user (found via session_token)
          * logged_in?
      2. Log in and out
          * login_user!
          * logout_user!
      3. Must be logged_in, and cannot be logged_in
          * require_user!
          * require_no_user!

-3. SessionController - [Readme3](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_3.md)

      1. Generate Controller, and add route (resource), only create, new, destroy
          resource :session, only: [:create, :destroy, :new]
      2. So only need to write
          * new (absolutely nothing besides render.)
      3. destroy
          * logout_user and redirect_to new_session_url
      4. create
          * Find by credentials, either flash error or login_user

-4. UserController - [Readme4](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_4.md)

      1. Generate controller, and add route (resources) only create, and new
          resources :users, only: [:create, :new]
      2. Add Params
      3. User#new should be simple
      4. Only create is left. If the user sucessfuly creates a new user, then log them in automatically, failing that, flash the errors they made.

-5. Application Layout - [Readme5](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_5.md)

      1. Have a bar on top that displays the name of the logged in user, and a log out button option
      2. Show nothing otherwise.
