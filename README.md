# Lytt Take-Home Challenge API 🎉

This is a simple API built in Ruby on Rails which accepts messages in three languages: English, German and Spanish. It generates a reply in the appropriate language, then stores both the reply and 
meta-data of the original message in a "session". 

## URL
all requests should follow root/api/v1/...
if you'd like to make calls to this API, it can be found at [https://peaceful-temple-48257.herokuapp.com/](https://peaceful-temple-48257.herokuapp.com/)

## Sending a message

### Request

`POST "/api/v1/sessions/{session-id}/messages"`
```
{
"text": "{user-text-input}",

}
```
Here `{session-id}`  is a `string`. If the session id you provide already exists, the message sent will be associated with that session; otherwise a new session will created with that id. 

### Response

If the message was successfully created you will receive a response like this:
``` 
{
"identifier": "14a9ef77e146",
"detected_language": "es",
"created_at": "2019-08-28T00:30:34.582Z"
}
```

Otherwise you will receive one like this:
``` 
{
"code": 422,
"message": "Unfortunately we don't have support for your language yet."
}
```


## Fetching a Message

### Request

`GET "/api/v1/sessions/{session-id}/messages/{identifier-id}"`

Here both `{session-id}` and `{identifier-id}` are `strings`

### Response

If a session with `{session-id}` exists and contains a message with `{identifier-id}`: 
```
{
"identifier": "{identifier-id}",
"detected_language": "es",
"created_at": "2019-08-28T00:30:34.582Z"
}
```
If the session and/or message don't exist:
``` 
{
"code": 404,
"message": "Resource doesn't exist"
}
```
## Fetching Replies
Each time a message is saved to a session, a reply is saved there as well, it's just not returned with the request. After a couple of messages are sent, 
the locale is set and all replies will be in the appropriate translation. 

### Request

To see all replies for a session:
`GET "/api/v1/sessions/{session-id}/replies"`

`{session-id}` must of course be a `string` that is already associated with a session.
### Response
```
{
"message": "Hi, how can I help you? You can write to me in English, German, or Spanish.",
"shortname": "Reply #1",
"reply_to": "{identifier-id}",
"created_at": "2019-08-28T00:22:45.051Z",
"language": "en"
},
{
"message": "Vale, cuéntame más al respecto.",
"shortname": "Reply #2",
"reply_to": "{identifier-id}",
"created_at": "2019-08-28T00:23:21.658Z",
"language": "es"
},
{
"message": "Gracias por tomarse el tiempo de escribirme hoy.",
"shortname": "Reply #3",
"reply_to": "{identifier-id}",
"created_at": "2019-08-28T00:23:23.134Z",
"language": "es"
},
{
"message": "No tengo nada más que decir sobre el tema.",
"shortname": "Reply #4",
"reply_to": "{identifier-id}",
"created_at": "2019-08-28T00:23:23.940Z",
"language": "es"
}
```
of course, if the session does not exist:
```
{
"code": 404,
"message": "Resource doesn't exist"
}
```

## Technologies Used
* Rails 6 
* Ruby 2.6.3
* Postgres

Rails is very scalable and makes building REST APIs a breeze. It is also helpful in that it can be used as a frontend framework, or easily connect to another frontend framework like React.
## To test this on your own machine
1. Fork this repository on GitHub
2. Clone your forked repository to your hard drive with `git clone https://github.com/YOURUSERNAME/lytt.git'
3. `cd lytt`
4. Initialize and start the app with `bundle install` and `rails db:migrate`
5. Serve it up with `rails s` and try making calls to `localhost:300/api/v1...` with an app like [Postman](https://www.getpostman.com)

### Testing with Rspec

`rspec` will launch the test suites. They  will all be green except for the `Validates queries` as this implementation doesn't currently validate user input.
## Final Thoughts/Considerations

### Some weaknesses of this implementation: 

   * the gem `whatLanguage` is used to determine in what language a message is written, yet it is remarkably unreliable when it comes to shorter strings (which I can assume most messages will be). *If you run into issues with error 422 you can try putting in longer messages*It would be worth considering the efficiency of using a service like [Google Cloud Translate](https://cloud.google.com/translate/docs/detecting-language).
   
   * Currently "sessions" are merely objects stored in a persistent database- this would certainly lead to quite a few issues and could be amended with something like Redis.
   
   * User input is not being validated, which means the API can break quite easily.
   
   I'm really interested in how an API like this would grow with the implementation of actual NLP. Right now of course, the API is completely dumb and only give responses based on how many messages have been sent (very reminicent of AIM spambots). Could a simple API like this be scaled with the logic for Natural Language Processing?
   
   ## All in all, this was a really fun challenge to work on! 🤘 
    
