# blockout

This app is a playground for:

 * [knockoutjs](https://github.com/knockout/knockout)
 * [eventmachine](https://github.com/eventmachine/eventmachine)
 * [em-websocket](https://github.com/igrigorik/em-websocket)
 * [sequel_pg](https://github.com/jeremyevans/sequel_pg)
 * [thin](https://github.com/macournoyer/thin)
 * [siege](http://www.joedog.org/siege-home/)


## Requirements

 * >= ruby 1.9.3
 * >= PostgreSQL 9.2beta3
 * a C build env for `sequel_pg`.

## Up & Running

 * create a `.env` file

```ruby
DATABASE_URL=postgres://path/to/pg/db
RACK_ENV=development
```

 * `bundle install`
 * `thin start`
 * open `http://localhost:9393/`
 * in another tab open `http://localhost:9393/gen`

### Bonus:
 * `brew install siege`
 * `siege -t 10s http://localhost:9393/gen`
 * `siege -t 10s http://localhost:9393/touch`
