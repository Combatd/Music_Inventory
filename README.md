# Music Inventory

This inventory system application will let record labels track their Bands, Albums and Tracks. Additionally we'll offer user accounts so users can comment on our inventory.

## Learning Goals

* Be able to build User Authorization
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
    * In ```#password=```, I will use ```self.password_digest=```. ```(self.___=``` calls a setter method defined for us by ActiveRecord, which is the state that is saved by self.save. While ```@___``` makes a new instance variable, unrelated to ```self.save```)

* In the User model, there will be an ```after_initialize``` callback to set the ```session_token``` before validation if it's not present.
* I need a ```User::find_by_credentials(email, password)``` method.

I will next need a ```UsersController``` and ```SessionsController```.
* I need methods on ```UsersController```` to allow new users to sign up.
    * They will be immediately logged in after signing up!

* The ```SessionsController``` handles all Authorization actions, so I won't make a model for this.
    * As usual, I will make Controller actions and routes for logging in and out. The session will be a singular resource!
    * ```SessionsController#create``` will re-set appropriate user ```session_token``` and ```session[:session_token]```
    * For testing, I will redirect them to a ```UsersController#show``` page until a proper view template is created.

Don't Repeat Yourself! I will write some methods in the abstract class ```ApplicationController```. There will be appropriate methods for views as helper methods, syntactically as ```helper_method :current_user```.
* ```#current_user``` returns the current user.
* ```#logged_in?``` returns boolean indicating if the user is signed in.
* ```#log_in_user!(user)``` resets the ```user```s session token and cookie.

### User Routes

```
    session POST   /session(.:format)                     sessions#create
            DELETE /session(.:format)                     sessions#destroy
new_session GET    /session/new(.:format)                 sessions#new
      users POST   /users(.:format)                       users#create
   new_user GET    /users/new(.:format)                   users#new
       user GET    /users/:id(.:format)                   users#show
```

I will create login/signup views and edit ```application.html.erb``` layout so that a logged in user is displayed a "sign-out" button and a logged-out user is displayed links to sign-up or sign-in pages. 
After that, it will be time to add some styling!

### Basic Styling
* I will need a header with the title of the Music Inventory Application with a cool font in my ```application.html.erb```
* ```flex``` in CSS should display logged-in/logged-out status on the right side of my header.
* I should make my ```<a>``` elements look more like buttons, which usually involves changing ```background_color``` and ```border-radius```.
* I need to have proper spacing and line alignment for my session forms.

## Phase 1: Bands, Albums, and Tracks
We cannot fully implement ```user``` features without building out core features of our inventory system.

When following the Model View Controller Software Architecture, it is best to build out one set of features and resources at a time.

* Database Migrations (Schema)
* Model definition (Ruby class with validations, associations, and helper methods)
* Routes (URL Path)
* Controllers Actions (Business Logic)
* Views (User Interface should match up with Controller Actions rendering them)

### Bands
* In the Migration ```CreateBands```, I will create a bands table with a name (required) column with server timestamps.
* I will create a ```Band``` model with a validation to ensure name is not null (value actually exists).
* Representational State Transfer REST API:
```
bands     GET    /bands(.:format)                       bands#index
          POST   /bands(.:format)                       bands#create
new_band  GET    /bands/new(.:format)                   bands#new
edit_band GET    /bands/:id/edit(.:format)              bands#edit
band      GET    /bands/:id(.:format)                   bands#show
          PATCH  /bands/:id(.:format)                   bands#update
          PUT    /bands/:id(.:format)                   bands#update
          DELETE /bands/:id(.:format)                   bands#destroy
```
* I can create a reusable form template ```_form.html.erb``` for the different pages rendered by ```BandsController```. Depending on the ```BandController``` action, a ternary operator checking [band.persisted?](https://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-persisted-3F) will change the form's action and method override to the correct URL path and HTTP Request method.
* For each ```BandsController``` action, I will first write the action, test it, then create the ```html.erb``` view that will be rendered.
* ```config.action_controller.default_protect_from_forgery = false``` would disable the CSRF Protection in ```config/application.rb```, which is meant to prevent phishing from fraudlent or fake copy sites. After testing the API endpoints manually one by one, we will need to re-enable CSRF protection before production!


### License Information

```
    Music Inventory - Inventory System for Record Labels
    Copyright (C) 2020  Mark Calvelo

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
```