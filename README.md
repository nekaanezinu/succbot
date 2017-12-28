# SuccBot
I am bot
## Setup
*everything in the setup is done from* `./bot` *folder*
1. Delete `./bot` file if it exists
2. Copy `./config/database.yml.example` to `./config/database.yml`
3. Change `./config/database.yml` to suit your needs. The default values for sqlite are given.
4. Copy `./config/secrets.yml.example` to `./config/secrets.yml`
5. Add your Discord app to `./config/secrets.yml`
6. Run `gem install bundler` if not already installed
7. Run `bundle install`
8. Run `rake db:migrate`
9. Run `rake db:import`
10. To launch the bot run `ruby bot.rb`