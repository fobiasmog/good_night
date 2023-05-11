# README

## Task
We would like you to implement a "good night" application to let users track when do they go to bed and when do they wake up.

We require some restful APIS to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records of a user's All friends from the previous week, which are sorted based on the duration of All friends sleep length.

Please implement the model, db migrations, and JSON API.
You can assume that there are only two fields on the users "id" and "name".

You do not need to implement any user registration API.


Models
* Users
* Friends
* SleepRecords


API
### prefix /api/v1

### resources :users, only: [:index]
* GET /users # all users list

### resources :friends, only: [:index, :create, :destroy] { get :week_chart }
* GET    /friends # list of all friends
* POST   /friends/:user_id # follow new friend
* DELETE /friends/:user_id # unfollow

### resources :sleep_records, only: [:index, :create, :update]
* GET   /sleep_records # list of all user tracks
* POST  /sleep_records # start tracker
* PATCH /sleep_records/:id # stop tracker
