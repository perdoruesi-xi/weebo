# Weebo Bot

A salah times bot.

![Weebo](http://vignette2.wikia.nocookie.net/jadensadventures/images/9/9a/FlubberWeebo.jpg)


## Getting Started

1. Use bundle to install the exact gems and versions that are needed. 
2. Run ``` ruby client.rb ```
``` ruby
require_relative "weebo"
require_relative "lib/bot"
require_relative "lib/wsample"
require_relative "lib/adapter"

Dir['lib/adapters/*.rb'].each {|file| require_relative file }

# Weebo Bot
weebo = Weebo::Bot.new
weebo.perform
```

## Adapters
Using lib/config.yml file you can specify all adpaters credentials:
```
slack:
  hook: "https://hooks.slack.com/services/T04.."
  channel: "#channel"
  username: "username"

hipchat:
  api_token: ""
  room: ""
  username: ""
```
## Third-party Adapters

Here is a list of known adapters, but please submit an issue to have yours added to the list:

* [Slack](https://slack.com)
* [HipChat](https://www.hipchat.com)

Interested in adding your own adapter? [Say Hello](mailto:korab@mozaix.net)

## To Do
- [ ] Emoji

## Contributing

If there is any thing you'd like to contribute or fix, please:

- Fork the repo
- Add tests for any new functionality
- Make your changes
- Verify all new &existing tests pass
- Make a pull request


## License

Distributed under the MIT License.
