# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
```ruby
ruby = 2.7.0
```

* Rails version
```ruby
rails = 6.0.3
```
* Bundle install
```
bundle install
```
* Create database & Migrate
```ruby
rake db:create db:migrate db:seed
```

* Export env variables
```env
export TAGGING_JWT_SECRET=generate secret key
```
* For ` login ` request

```http
http://localhost:3000/login
```
> Required params ` email ` and ` password ` 
```json
{
  "user":{
	  "email": "admin@example.com",
	  "password": "password"
  }
}
```
* After successfull login request, copy the token from Authorization header and send along with all the requests

> as  ` Bearer your_token`

* For list of users
```http
GET http://localhost:3000/api/v1/users
```

* To search users
> search with first_name or last_name or email
```http
GET http://localhost:3000/api/v1/users?search=james
```

* To sort users
```http
GET http://localhost:3000/api/v1/users/sort_field?field=first_name&order_type=asc
```
* To Create user
```http
POST http://localhost:3000/api/v1/users
```

* Sample user Object for creation

```json
{
  "user":{
	  "email": "sample@example.com",
	  "name": "sample name",
	  "first_name": "James",
	  "last_name": "Bond",
	  "password": "password",
	  "tag_list": "user"
  }
}
```
* For update user
```http
PATCH http://localhost:3000/api/v1/tusers/:id
```
* To disable the user just hit the with no parameters user will be disabled and enable again
```http
PATCH http://localhost:3000/api/v1/users/:id/disable_user
```

* To delete the user
```http
DELETE http://localhost:3000/api/v1/tags/:id
```
* To add tags to user, add tag_list to user object
```http
PATCH http://localhost:3000/api/v1/users/:id/add_tag
```
* To remove tags to user, add tag_list to user object
```http
PATCH http://localhost:3000/api/v1/users/:id/remove_tag
```

* To list tags
```http
GET http://localhost:3000/api/v1/tags
```
* To create new tag
```http
POST http://localhost:3000/api/v1/tags
```
* sample Tag Object for creation

```json
{
	"acts_as_taggable_on_tag": {"name": "user"}
}
```

* To update tag
```http
PATCH http://localhost:3000/api/v1/tags/:id
```

* To sort tags
```http
GET http://localhost:3000/api/v1/tags/sort_field?field=name&order_type=asc
```