# README
# INSTALL
# Version
-   Ruby version: 2.3.1
-   Gem version: 2.5.1
-   Rails version: Rails 5.1.4
-   Sqlite3 version: 3.11.0
# Lam chuc nang moi
- Tai nhanh develop, lay code moi nhat ve:
     git pull upstream develop
- `git checkout -b nguoi_lam/ten_chuc_nang`
    vd `git checkout -b taond/login`
# Run
- Chú ý: để cài bower máy cần cài node, cài nodejs như sau: `sudo apt-get install nodejs` & `sudo apt-get install nodejs-legacy`
-   `bundle install`
-   `rails db:migrate`
-   `rake bower:install`
-   `rails server`
# Application routes

```
Prefix Verb   URI Pattern                    Controller#Action
                  skills GET    /skills(.:format)              skills#index
                         POST   /skills(.:format)              skills#create
               new_skill GET    /skills/new(.:format)          skills#new
              edit_skill GET    /skills/:id/edit(.:format)     skills#edit
                   skill GET    /skills/:id(.:format)          skills#show
                         PATCH  /skills/:id(.:format)          skills#update
                         PUT    /skills/:id(.:format)          skills#update
                         DELETE /skills/:id(.:format)          skills#destroy
                   types GET    /types(.:format)               types#index
                         POST   /types(.:format)               types#create
                new_type GET    /types/new(.:format)           types#new
               edit_type GET    /types/:id/edit(.:format)      types#edit
                    type GET    /types/:id(.:format)           types#show
                         PATCH  /types/:id(.:format)           types#update
                         PUT    /types/:id(.:format)           types#update
                         DELETE /types/:id(.:format)           types#destroy
               companies GET    /companies(.:format)           companies#index
                         POST   /companies(.:format)           companies#create
             new_company GET    /companies/new(.:format)       companies#new
            edit_company GET    /companies/:id/edit(.:format)  companies#edit
                 company GET    /companies/:id(.:format)       companies#show
                         PATCH  /companies/:id(.:format)       companies#update
                         PUT    /companies/:id(.:format)       companies#update
                         DELETE /companies/:id(.:format)       companies#destroy
        new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
            user_session POST   /users/sign_in(.:format)       devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
       new_user_password GET    /users/password/new(.:format)  devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
           user_password PATCH  /users/password(.:format)      devise/passwords#update
                         PUT    /users/password(.:format)      devise/passwords#update
                         POST   /users/password(.:format)      devise/passwords#create
cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
       user_registration PATCH  /users(.:format)               devise/registrations#update
                         PUT    /users(.:format)               devise/registrations#update
                         DELETE /users(.:format)               devise/registrations#destroy
                         POST   /users(.:format)               devise/registrations#create
                    root GET    /                              home#index
```
