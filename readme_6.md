### Forms, Forms, Forms

-1. The authenticity token to be places when you make any non-GET request to rails, used to prevent CSRF , Cross Site Scripting Attacks. (Prob have a snippit for this. )

```html
<input type="hidden"
       name="authenticity_token"
       value="<%= form_authenticity_token %>">
```

-2. Create a new folder called shared in views and a new file inside. Just hit new file and insert this. the subsequent files will appear automatcially.
```
app/views/shared/_errors.rb
```

-3. General Code to flash Errors. Make this avaialble to multiple views. - Put this into that errors shared file.
```html
<% if flash[:errors] %>
  <ul>
  <% flash[:errors].each do |error| %>
    <li><%= error %></li>
  <% end %>
  </ul>
<% end %>
```

-4 Sign in page at session views - new.html.erb
```ruby
<h1>Sign in</h1>

<%= render "shared/errors" %>

<form action="<%= session_url %>" method="post">
  <input
    type="hidden"
    name="authenticity_token"
    value="<%= form_authenticity_token %>">

  <label for="user_username">User Name</label>
  <input type="text" name="user[username]" id="user_username">
  <br>

  <label for="user_password">Password</label>
  <input type="password" name="user[password]" id="user_password">
  <br>

  <input type="submit">
</form>
```

-5 New USER sign up page in User views - new.html.erb
```ruby
<h1>New User</h1>

<%= render "shared/errors" %>

<form action="<%= users_url %>" method="post">
  <input
    type="hidden"
    name="authenticity_token"
    value="<%= form_authenticity_token %>">

  <label for="user_username">User Name</label>
  <input type="text"
         name="user[username]"
         id="user_username"
         value="<%= @user.username %>">
  <br>

  <label for="user_password">Password</label>
  <input type="password"
         name="user[password]"
         id="user_password"
         value="<%= @user.password %>">
  <br>

  <input type="submit">
</form>
```

-6 Anatomy of Forms to be continued...
