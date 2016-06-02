I will build this MusicApp with authentication step by step, having all the steps here, as well as committing early and often, so that if I have to go back, I can easily see what fragments of the code were relevant. Simultaneous to this, I will also reference the source material.

ALSO Regarding authentication- or AUTH,
unlike the HW or videos. there will be no bad code, or 'naive' way of doing things first. There will be only the correct way

NB: Code will be annotated with comments corresponding to the steps that helped create it.

Example - Index added during Step 7 is commented as #7

    add_index :users, :session_token, unique: true #7
    add_index :users, :username, unique: true #7

Finally, there will be a correseponding useful_things.md that will have more information-
Marked at UT #1 - to indicate which number in the useful things file can help you.

1. Start a new rails project but have the PSQL DB so
        rails new MusicApp -d postgresql

2. Start new Git Project to Keep track.
          GIT COMMIT 1: Initial Project Start

3. Modify gem file to include:
        # Place these in the general section of the gem file.
        gem 'pry-rails'
        gem 'annotate'
        gem 'bcrypt'

        # Do not use the following during assessment because it messes with RSPEC.
        # Use these only during development.
        # DONT put where it says TEST and development beacsue it can bind to a test and make it pass when it should have failed

        gem 'better_errors'
        gem 'binding_of_caller'

4. Basic Setup Commands
        bundle install
        rake db:create

5. I learned this yesteraday, that you can just say rails generate model, and it will generate the corrosponding migration for you so you have less steps to deal with . Generate model will take an options hash. Please note, I'm calling the column username, but it will contain email addresses.
        rails g model User username:string password_digest:string session_token:string

6. Modify User migration by adding constraints to the table, in this case, nothing can be null.

7. Speed up lookup of users by either username or session_token; therefore add index

8. Final code of the user's migration

        class CreateUsers < ActiveRecord::Migration
          def change
            create_table :users do |t|
              t.string :username, null: false #6
              t.string :password_digest, null: false #6
              t.string :session_token, null: false #6

              t.timestamps null: false #6
            end

            add_index :users, :session_token, unique: true #7
            add_index :users, :username, unique: true #7
          end
        end

9. UC #1 - has the handy chart showing database level constraints and the corresponding model level validation
          GIT COMMIT 2: "Handled User Migration"   

10. Speaking of corresponding model level validation- Add that. Function wise, Validates is for the built in validation, while validate is to trigger your own custom validation method.

11. Numbe 11
