Dotenv.load
Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :twitch, ENV["CLIENT_ID"], ENV["CLIENT_SECRET"]
  provider :google_oauth2, '801119925631-vdafom612rle0lpkh6lqh7u01di3jegv.apps.googleusercontent.com', 'xdPl7o6uzVwyyWVbRvT2JIrj'
end