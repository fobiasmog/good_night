# README

## Task
```
We would like you to implement a "good night" application to let users track when do they go to bed and when do they wake up.

We require some restful APIS to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records of a user's All friends from the previous week, which are sorted based on the duration of All friends sleep length.

Please implement the model, db migrations, and JSON API.
You can assume that there are only two fields on the users "id" and "name".

You do not need to implement any user registration API.
```

## Explanation and simplifications
In this version of the "Good Night" I made not super complicated code.
We have 3 models:
* User - user, haha :)
* UserFriends - this model using for storing friends relations. But I didn't make bi-directional friendships (so in my implementation it's more like "following")
* SleepRecords - I assume, that at the moment the user can have only one active (not stopped) record (we can't start sleeping while we sleeping :))

What's if code will grow? We'll move business logic to Services, complicated queries to Queries, and add some Serializers for formatting json

**important**
Because I didn't implement user auth, I assume, that in real API we'll use some JWT tokens. But right now, for simplifications, with every API call, we need to use the parameter `auth_user_id` with the User.id value

## Models
* Users
* UserFriends
* SleepRecords

## API
### prefix /api/v1

### resources :users, only: [:index]
* GET /users # all users list

### resources :friends, only: [:index, :create, :destroy]
* GET    /user_friends # list of all friends
* POST   /user_friends/:user_id # follow new friend
* DELETE /user_friends/:user_id # unfollow
* GET    /user_friends/sleep_records # See the sleep records of a user's All friends from the previous week

### resources :sleep_records, only: [:index, :create, :update]
* GET   /sleep_records # list of all user tracks
* POST  /sleep_records # start tracker
* PATCH /sleep_records/:id # stop tracker
