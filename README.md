![SHORTIFY](https://i.postimg.cc/jjgdFYFj/logo-redux.png)

#### Shortify | URL Shortener

(Also known as) shtfy is a simple and very straight to the point URL shortener that does not require a lot to setup.

Deploys easily to Heroku, has a seed file to get things going and has a minimalist UI to create shortened URLs!

URLs are shortened by multiple algorithms, One of the currently implemented ones is by using a cryptographic hashing function called SHA1 which renders a 40 character long hexadecimal based on the original URL (link) which is then reduced further to only 8, giving a total of 12870 possible combinations.

The other algorithm currently implemented is by Base64 encoding the original link, taking the last 10 characters, stripping down spaces and padding characters (equal "=" signs) and then taking the rest to be used as the short_id for the short url resulting in a total of 4,426,165,368 possible combinations, which makes this algorithm the one that is currently being used as default.

In its current state, there is no proper API available but users are allowed to create URLs by sending requests such as:

```
curl -X POST -d "original_link=https://linktoshorten.com" http://shtfy.herokuapp.com/urls.json
```

The application uses Sidekiq in the background to fetch link contents using HTTParty and then parses their title and description by using Nokogiri.

The default root view is the URL index page which displays the current top 100 urls by visits (currently uncached). Visits on each page could be analized in depth in the future given the fact that they are a separate model, currently url_visits only hold information about the time of the visit (created_at).