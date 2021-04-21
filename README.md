# Template Leaderboard website

This project is a pretty simple layout of what a time-based leaderboard could look like, based on Ruby on Rails. Created with speedrunning in mind, it sorts by lowest time, however it can work great with anything time based.

## How to set up:

-   First thing you'll have to do once you clone the repository for yourself is create a `seeds.rb` file in the `/db` folder. This is where you'll create "games", aka categories. If you don't have categories created, nothing can really be done on the website.

-   Second, you'll need to create an `omniauth.rb` file in `/config/initializers`. The template I'll link at the bottom is specifically for Google OAuth, but you can change this or remove as you would like.

## How to use:

-   You're able to look at the leaderboards without being logged in. I think this is the best decision, as it allows for people to hopefully see times on the board and be inspired to go for times themselves.

-   Once you log in through either method, you're given the ability to submit "runs" once you click on a game. Users are able to click a game from the drop down, and are able to type in the digits of their run.

-   Users are also able to edit their own runs. They cannot change the game, but only change the digits of the time incase they mistyped. If they submitted to the wrong run altogether, they have the ability to delete the run.

-   If they want to see all the runs done by a specific user, they can click that user's name. Makes for easy accesability to maybe compare against someone you would like to beat one day

### OmniAuth.rb code layout

Taken from 'https://github.com/zquestz/omniauth-google-oauth2', as this is the Gem that I used.

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
```
