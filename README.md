Logobox [![Build Status](https://travis-ci.org/ucetnictvi-on-line/logobox.svg?branch=master)](https://travis-ci.org/ucetnictvi-on-line/logobox) [![Code Climate](https://codeclimate.com/github/ucetnictvi-on-line/logobox/badges/gpa.svg)](https://codeclimate.com/github/ucetnictvi-on-line/logobox) [![Test Coverage](https://codeclimate.com/github/ucetnictvi-on-line/logobox/badges/coverage.svg)](https://codeclimate.com/github/ucetnictvi-on-line/logobox)
=============

Logobox translates [ICO](https://cs.wikipedia.org/wiki/Identifika%C4%8Dn%C3%AD_%C4%8D%C3%ADslo_osoby) of the company into appropriate logo url at www.logobox.cz

It can check that the logo is uploaded and make the ICO validation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logobox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logobox

## Usage

`Logobox.logo_exists?(ico)` - returns true if ICO is valid and logo exists on logobox.cz (Internet connection is required)

`Logobox.generate_logo_url(ico)` - returns logo url at logobox.cz (even if it's the default one or ico is invalid)

`Logobox.generate_logo_url!(ico)` - returns logo url, but raises error if ico is invalid or logo doesn't exist on logobox.cz (Internet connection is required)

## Example
```ruby
class ContactDecorator < Draper::Decoration
  ...
  def logo_url
    Logobox.generate_logo_url(contact.ico, :medium)
  end
  ...
end
```

```html
<img src="<%= @contact.logo_url %>">
```

## Contributing

1. Fork it ( https://github.com/desofto/logobox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
