-1 Add Feature so that if a user is currently logged in, we display the current username they are logged in under as well as the option to log out. Put this in application.html.erb whcih is found in layout section of views.
```
<!-- app/views/layouts/application.html.erb #1-->
    <% if logged_in? %>
      <ul>
        <li>Logged in as: <%= current_user.username %></li>
        <li><%= button_to "Logout", session_url, method: :delete %></li>
      </ul>
    <% end %>
```

-2 Git commit - Added header that has logged in user as well as option to log out.
