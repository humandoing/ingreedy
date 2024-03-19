# Usage

```ruby
result = Ingreedy.parse('1 lb. potatoes')
print result.amount
  #=> 1.0
print result.unit
  #=> :pound
print result.ingredient
  #=> "potatoes"
```

### I18n and custom dictionaries

```ruby
Ingreedy.dictionaries[:fr] = {
  units: { dash: ['pincée'] },
  numbers: { 'une' => 1 },
  prepositions: ['de']
  range_separators: ['ou']
}

Ingreedy.locale = :fr # Also automatically follows I18n.locale and I18n.fallbacks if available

result = Ingreedy.parse('une pincée de sucre')
print result.amount
  #=> 1.0
print result.unit
  #=> :dash
print result.ingredient
  #=> "sucre"
```

### Handling amounts

By default, Ingreedy will convert all amounts to a rational number:

```ruby
result = Ingreedy.parse("1 1/2 cups flour")
print result.amount
  #=> 3/2
```

However, setting `Ingreedy.preverse_amounts = true`, will allow amounts
to be detected and returned as originally input:

```ruby
Ingreedy.preserve_amounts = true

result = Ingreedy.parse("1 1/2 cups flour")
print result.amount
  #=> 1 1/2
```

# Pieces of Flair
- [![Gem Version](https://badge.fury.io/rb/ingreedy.svg)](http://badge.fury.io/rb/ingreedy)
- [![Build Status](https://secure.travis-ci.org/iancanderson/ingreedy.svg?branch=master)](http://travis-ci.org/iancanderson/ingreedy)
- [![Code Climate](https://codeclimate.com/github/iancanderson/ingreedy.svg)](https://codeclimate.com/github/iancanderson/ingreedy)
- [![Coverage Status](https://coveralls.io/repos/iancanderson/ingreedy/badge.svg)](https://coveralls.io/r/iancanderson/ingreedy)

# Development

To try to make development easier, I have added a `Dockerfile` and `docker-compose.yml` to 
make things as boring and simple as possible. If you have Docker installed you should be
able to simply start developing (and work on the specs) by doing:

```
docker-compose build
docker-compose run ingreedy bash

# Now you will get a bash prompt inside the docker container
bundle # to install gems
bundle exec rspec

```

I realize that the above could be improved with better Dockerfile or docker-compose.yml or
changing the way the volumes are handled, or making the container totally transient. This
was just the easiest way for me to make the changes I needed, and I'm still pretty new to
working on Gems in general.
