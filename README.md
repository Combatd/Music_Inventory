# Music Inventory

This inventory system application will let record labels track their Bands, Albums and Tracks. Additionally we'll offer user accounts so users can comment on our inventory.

## Learning Goals

* Be able to build User Auth without looking at old code or demos
* Know how to nest routes
* Be able to link between different views using a tags and rails URL helpers
* Be able to trigger controller actions from views using forms and links
* Know how to check that a current user exists before displaying content
* This project will not use ```form_for```

## Warm Up: Authentication

```User``` model will have prerequisites of authentication. Email addresses are in lieu of usernames; in the bonus phase, emails will be sending confirmation emails and other stuff.

```users``` table:  store an email, password_digest and session_token. Add database constraints (require all fields), and indices to ensure uniqueness of emails and speed up the lookup by session_token.

* Methods to deal with the session token: ```User::generate_session_token```, ```User#reset_session_token!``` and ```User#ensure_session_token```.
* ```User#password=(password)``` method which actually sets the ```password_digest``` attribute using BCrypt, and a ```User#is_password?(password)``` method to check the users' password when they log in