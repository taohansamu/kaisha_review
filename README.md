# README
# INSTALL
# Version
-   Ruby version: 2.3.1
-   Gem version: 2.5.1
-   Rails version: Rails 5.1.4
-   Sqlite3 version: 3.11.0

# Run
- Chú ý: để cài bower máy cần cài node, cài nodejs như sau: `sudo apt-get install nodejs` & `sudo apt-get install nodejs-legacy` & `npm install -g bower` (sudo nếu cần thiết).



-   `bundle install`
-   `rails db:migrate`
-   `bower install`
-   `npm install`
-   `rails s`

# Active gui mail:

-   Trong file `/app/models/user.rb`, bỏ hàm sau đi

``` ruby
def confirmation_required?
      false
end
```
- Trong file `/config/environments/development.rb`: thay  `ENV["GMAIL_USERNAME"]` & `ENV["GMAIL_PASSWORD"]` bằng gmail và mật khẩu thật. Nhớ bật chế độ gửi email từ ngoài cho email.
# Create admin
-   Signup 1 tai khoan thuong
-   rails c
-   user = User.first
-   user.scope = 'admin'
-   user.save

# Application routes

```
                               Prefix Verb     URI Pattern                                             Controller#Action
                 users_update_profile PUT      /users/update_profile(.:format)                         users#update_profile
                                      DELETE   /destroy_relationship_by_company/:company_id(.:format)  relationships#destroy_by_company
                      update_password PUT      /update_password(.:format)                              devise/registrations#update_password
                           home_index GET      /home/index(.:format)                                   home#index
                                      GET      /companies/:company_id/reviews/current_review(.:format) reviews#get_current_review
                     new_user_session GET      /users/sign_in(.:format)                                users/sessions#new
                         user_session POST     /users/sign_in(.:format)                                users/sessions#create
                 destroy_user_session DELETE   /users/sign_out(.:format)                               users/sessions#destroy
     user_facebook_omniauth_authorize GET|POST /users/auth/facebook(.:format)                          users/omniauth_callbacks#passthru
      user_facebook_omniauth_callback GET|POST /users/auth/facebook/callback(.:format)                 users/omniauth_callbacks#facebook
user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)                     users/omniauth_callbacks#passthru
 user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format)            users/omniauth_callbacks#google_oauth2
                    new_user_password GET      /users/password/new(.:format)                           devise/passwords#new
                   edit_user_password GET      /users/password/edit(.:format)                          devise/passwords#edit
                        user_password PATCH    /users/password(.:format)                               devise/passwords#update
                                      PUT      /users/password(.:format)                               devise/passwords#update
                                      POST     /users/password(.:format)                               devise/passwords#create
             cancel_user_registration GET      /users/cancel(.:format)                                 devise/registrations#cancel
                new_user_registration GET      /users/sign_up(.:format)                                devise/registrations#new
               edit_user_registration GET      /users/edit(.:format)                                   devise/registrations#edit
                    user_registration PATCH    /users(.:format)                                        devise/registrations#update
                                      PUT      /users(.:format)                                        devise/registrations#update
                                      DELETE   /users(.:format)                                        devise/registrations#destroy
                                      POST     /users(.:format)                                        devise/registrations#create
                new_user_confirmation GET      /users/confirmation/new(.:format)                       devise/confirmations#new
                    user_confirmation GET      /users/confirmation(.:format)                           devise/confirmations#show
                                      POST     /users/confirmation(.:format)                           devise/confirmations#create
          open_all_user_notifications POST     /users/:user_id/notifications/open_all(.:format)        users/notifications#open_all {:target_type=>"users"}
               move_user_notification GET      /users/:user_id/notifications/:id/move(.:format)        users/notifications#move {:target_type=>"users"}
               open_user_notification POST     /users/:user_id/notifications/:id/open(.:format)        users/notifications#open {:target_type=>"users"}
                   user_notifications GET      /users/:user_id/notifications(.:format)                 users/notifications#index {:target_type=>"users"}
                    user_notification GET      /users/:user_id/notifications/:id(.:format)             users/notifications#show {:target_type=>"users"}
                                      DELETE   /users/:user_id/notifications/:id(.:format)             users/notifications#destroy {:target_type=>"users"}
                                               /cable                                                  #<ActionCable::Server::Base:0x00000006a0f338 @mutex=#<Monitor:0x00000006a0f310 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x00000006a0f2c0>>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
                               skills GET      /skills(.:format)                                       skills#index
                                      POST     /skills(.:format)                                       skills#create
                            new_skill GET      /skills/new(.:format)                                   skills#new
                           edit_skill GET      /skills/:id/edit(.:format)                              skills#edit
                                skill GET      /skills/:id(.:format)                                   skills#show
                                      PATCH    /skills/:id(.:format)                                   skills#update
                                      PUT      /skills/:id(.:format)                                   skills#update
                                      DELETE   /skills/:id(.:format)                                   skills#destroy
                                types GET      /types(.:format)                                        types#index
                                      POST     /types(.:format)                                        types#create
                             new_type GET      /types/new(.:format)                                    types#new
                            edit_type GET      /types/:id/edit(.:format)                               types#edit
                                 type GET      /types/:id(.:format)                                    types#show
                                      PATCH    /types/:id(.:format)                                    types#update
                                      PUT      /types/:id(.:format)                                    types#update
                                      DELETE   /types/:id(.:format)                                    types#destroy
                      company_reviews GET      /companies/:company_id/reviews(.:format)                reviews#index
                                      POST     /companies/:company_id/reviews(.:format)                reviews#create
                   new_company_review GET      /companies/:company_id/reviews/new(.:format)            reviews#new
                  edit_company_review GET      /companies/:company_id/reviews/:id/edit(.:format)       reviews#edit
                       company_review GET      /companies/:company_id/reviews/:id(.:format)            reviews#show
                                      PATCH    /companies/:company_id/reviews/:id(.:format)            reviews#update
                                      PUT      /companies/:company_id/reviews/:id(.:format)            reviews#update
                                      DELETE   /companies/:company_id/reviews/:id(.:format)            reviews#destroy
                            companies GET      /companies(.:format)                                    companies#index
                                      POST     /companies(.:format)                                    companies#create
                          new_company GET      /companies/new(.:format)                                companies#new
                         edit_company GET      /companies/:id/edit(.:format)                           companies#edit
                              company GET      /companies/:id(.:format)                                companies#show
                                      PATCH    /companies/:id(.:format)                                companies#update
                                      PUT      /companies/:id(.:format)                                companies#update
                                      DELETE   /companies/:id(.:format)                                companies#destroy
                       following_user GET      /users/:id/following(.:format)                          users#following
                                users GET      /users(.:format)                                        users#index
                                      POST     /users(.:format)                                        users#create
                             new_user GET      /users/new(.:format)                                    users#new
                            edit_user GET      /users/:id/edit(.:format)                               users#edit
                                 user GET      /users/:id(.:format)                                    users#show
                                      PATCH    /users/:id(.:format)                                    users#update
                                      PUT      /users/:id(.:format)                                    users#update
                                      DELETE   /users/:id(.:format)                                    users#destroy
                    followers_company GET      /companies/:id/followers(.:format)                      companies#followers
                                      GET      /companies(.:format)                                    companies#index
                                      POST     /companies(.:format)                                    companies#create
                                      GET      /companies/new(.:format)                                companies#new
                                      GET      /companies/:id/edit(.:format)                           companies#edit
                                      GET      /companies/:id(.:format)                                companies#show
                                      PATCH    /companies/:id(.:format)                                companies#update
                                      PUT      /companies/:id(.:format)                                companies#update
                                      DELETE   /companies/:id(.:format)                                companies#destroy
                        relationships POST     /relationships(.:format)                                relationships#create
                         relationship DELETE   /relationships/:id(.:format)                            relationships#destroy
                                 root GET      /                                                       home#index                          home#index
```
