I will build this MusicApp with authentication step by step, having all the steps here, as well as committing early and often, so that if I have to go back, I can easily see what fragments of the code were relevant. Simultaneous to this, I will also reference the source material.

NB: Code will be annotated with comments corresponding to the steps that helped create it. i.e. If you are unclear why a particular method or section of code is where it is, you can reference the comment # that shows which step added that line. And it will usually have the logic as for why that decision was made.

Example: ```attr_reader :password #14``` line was added to the User Model in step 14, so you can reference that for more information. 

The final code will look like this
```ruby
 require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader :password #14

  after_initialize :ensure_session_token #21

  validates :username, :session_token, presence: true, uniqueness: true #11
  validates :password_digest, presence: { message: "Password can't be blank" } #11, #12
  validates :password, length: { minimum: 6, allow_nil: true } #14

  def password=(password) #13
    @password = password #14 setting it during the password_setting to test validation
    self.password_digest = BCrypt::Password.create(password)
  end #13

  def is_password?(password) #13
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end #13

  def self.find_by_credentials(username, password) #23
   user = User.find_by_username(username)
   return nil if user.nil?
   user.is_password?(password) ? user : nil
 end

  def self.generate_session_token #17
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token! #18
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token #19
    self.session_token ||= self.class.generate_session_token
  end
end
```

Finally, there will be a correseponding useful_things.md that will have more information-
Marked at UT #1 - to indicate which number in the useful things file can help you.

### Initial Setup and User Migration and Model

-1. Start a new rails project but have the PSQL DB so
```ruby
        rails new MusicApp -d postgresql
```

-1.5. - Per @Sjern suggestion, remember that if you make postgresql your database, that you MUST LAUNCH the companion program. It is running if you see a little elephant in the top right of you toolbar.


-2. Start new Git Project to Keep track.
```ruby
          GIT COMMIT 1: Initial Project Start
```
-3. Modify gem file to include:
```ruby
        # Place these in the general section of the gem file.
        gem 'pry-rails'
        gem 'annotate'
        gem 'bcrypt'

        # Do not use the following during assessment because it messes with RSPEC.
        # Use these only during development.
        # DONT put where it says TEST and development beacsue it can bind to a test and make it pass when it should have failed

        gem 'better_errors'
        gem 'binding_of_caller'
```
-4. Basic Setup Commands
```ruby
        bundle install
        rake db:create
```
-5. I learned this yesteraday, that you can just say rails generate model, and it will generate the corrosponding migration for you so you have less steps to deal with . Generate model will take an options hash. Please note, I'm calling the column username, but it will contain email addresses.
```ruby
        rails g model User username:string password_digest:string session_token:string
```
-6. Modify User migration by adding constraints to the table, in this case, nothing can be null.

-7. Speed up lookup of users by either username or session_token; therefore add index

-8. Final code of the user's migration
```ruby
        class CreateUsers < ActiveRecord::Migration
          def change
            create_table :users do |t|
              t.string :username, null: false #6
              t.string :password_digest, null: false #6
              t.string :session_token, null: false #6

              t.timestamps
            end

            add_index :users, :session_token, unique: true #7
            add_index :users, :username, unique: true #7
          end
        end
```
-9. UC #1 - has the handy chart showing database level constraints and the corresponding model level validation

          GIT COMMIT 2: "Handled User Migration"   

-10. Speaking of corresponding model level validation- Add that. Function wise, Validates is for the built in validation, while validate is to trigger your own custom validation method.

-11. In the User model, add the simple validations that correspond to the database constraints
```ruby
       validates :username, :session_token, presence: true, uniqueness: true #11
        validates :password_digest, presence: true #11
```
-12. Because users might not know what a password digest, add the message "password cant be blank instead.
```ruby
        validates :password_digest, presence: { message: "Password can't be blank" } #11, #12
```
-13. Add User#password= and User#is_password? so that the user can save a password, as well as confirm if the password they provide hashes to the digest we have on file.
NB: you are using self.password_diget because you want to avoid using an instance variable such as @password_diget
```ruby
        def password=(password)
          self.password_digest = BCrypt::Password.create(password)
        end #13

        def is_password?(password)
          BCrypt::Password.new(self.password_digest).is_password?(password)
        end #13
```
-14. BUT we do wnat to test length of password, so we can have @password as an instance variable during the #password= method, which we can reach with a attr_reader, and then add model level validation for it, while allowing nil for it if it is not set. This step involves doing 3 things. Setting instance variable @password, during the password set method, adding a reader so it is accessible to the model even if not in the database, and the adding that validation that tests minimum length while still allowing nil when the password isnt being set.
```ruby
        class User < ActiveRecord::Base
          attr_reader :password #14

          validates :username, :session_token, presence: true, uniqueness: true #11
          validates :password_digest, presence: { message: "Password can't be blank" } #11, #12
          validates :password, length: { minimum: 6, allow_nil: true } #14

          def password=(password) #13
            @password = password #14
            self.password_digest = BCrypt::Password.create(password)
          end #13

          def is_password?(password) #13
            BCrypt::Password.new(self.password_digest).is_password?(password)
          end #13
        end
```
-15. Commit User Model with password_setting and checking abilities
          GIT COMMIT 3: "User Model: Setting and checking Passwords"    

-16. Next Section, setting up session_token logic in the User Model, User::generate_session_token, User#reset_session_token! and User#ensure_session_token.

-17. Generate session token as a class method because it dries out the places where a session token is generated, and we can always make it longer or change its parameters without hunting down all the places we generated it.
```ruby
          def self.generate_session_token #17
            SecureRandom::urlsafe_base64(16)
          end
```
-18. Reset_session token
```ruby
          def reset_session_token! #18
            self.session_token = self.class.generate_session_token
            self.save!
            self.session_token
          end
```
-19. Ensure Session Token- Provide one if not given
```ruby
          private

        def ensure_session_token #19
          self.session_token ||= self.class.generate_session_token
        end
```
-20. Git Commit 4- All Session Token logic
            GIT COMMIT 4: "Session Token Logic"

-21. Totally Forgot, to add to the top to run the ensure session token logic.
```ruby
          after_initialize :ensure_session_token #21
```
-22. Git Commit 5- Actuall All Session Token logic
            GIT COMMIT 5: "Session Token Logic: Forgot to ensure session token after initialize"

-23. Add Find by Credentials Logic
```ruby
          def self.find_by_credentials(username, password) #23
            user = User.find_by_username(username)
            return nil if user.nil?
            user.is_password?(password) ? user : nil
          end
```
-24. Git Commit 6- User Model complete for now, added Find by Credentials.
            GIT COMMIT 6: Completed User Model, added find by credentials

-25. Save Space Here Perhaps for Entire User File. Bask in your completed User Model. (see above)

-26. Final Git Commit in USer MDOel, added Finished Usermodel to read me
        GIT COMMIT 7: "Final User Model Added to readme"

-27 -Rememeber to Require BCrypt.
```ruby
require 'bcrypt'
```
