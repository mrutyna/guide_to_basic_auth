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
