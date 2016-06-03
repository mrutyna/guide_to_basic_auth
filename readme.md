Basic Authentication Summary

This summary can be used in two different ways. Just this page will list only the function that you have to write. Therefore allowing you to practice the functions themselves without having to remember the name of the 22 functions.

IF you need additional resources, such as how to write the function, or an explanation why certain things are being done, you can hit on the link for the section to see a detailed explanation.

My goal in writing this, was that I didn't like how the HW, readings, and video showed you a hodgepoge way of building authentication: showing you a 'naive' implementation, and making you jump in and out of dozen of different files over the course of one reading.

My philosophy in this was to combine only the "right way" with no references to piecemeal implementation of bad code. I believe you can write one entire file step by step and complete it before moving on to the next one.

If I made any mistakes, or you have any suggestions, feel free to open up an issue, and I will try to respond to it.

-1. [Basic Setup and User Model](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_1.md)

    1. Generate Model for User, Require BCRYPT ***
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


-2. [ApplicationController](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_2.md)

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

-3. [SessionController](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_3.md)

      1. Generate Controller, and add route (resource), only create, new, destroy
          resource :session, only: [:create, :destroy, :new]
      2. So only need to write
          * new (absolutely nothing besides render.)
      3. destroy
          * logout_user and redirect_to new_session_url
      4. create
          * Find by credentials, either flash error or login_user

-4. [UserController](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_4.md)

      1. Generate controller, and add route (resources) only create, and new
          resources :users, only: [:create, :new]
      2. Add Params
      3. User#new should be simple
      4. Only create is left. If the user sucessfuly creates a new user, then log them in automatically, failing that, flash the errors they made.

-5. [Application Layout](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_5_application.md)

      1. Have a bar on top that displays the name of the logged in user, and a log out button option
      2. Show nothing otherwise.

-6 [FORMS for signing in and signing out](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_6.md)

-7 [General Purpose Super Phone](https://github.com/mrutyna/guide_to_basic_auth/blob/master/readme_7.md)
