Logobox [![Build Status](https://travis-ci.org/ucetnictvi-on-line/logobox.svg?branch=master)](https://travis-ci.org/ucetnictvi-on-line/logobox) [![Code Climate](https://codeclimate.com/github/ucetnictvi-on-line/logobox/badges/gpa.svg)](https://codeclimate.com/github/ucetnictvi-on-line/logobox) [![Test Coverage](https://codeclimate.com/github/ucetnictvi-on-line/logobox/badges/coverage.svg)](https://codeclimate.com/github/ucetnictvi-on-line/logobox)
=============

[Logobox](http://www.logobox.cz/) is a database of Czech company logos. Currently it contains more than **13 000** logos.

This gem knows how to construct right URLs to those logos. It can also check if logo for company is present on Logobox. All you need is ICO of the company.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logobox'
```

## Usage
Logobox has 3 public methods:

##### `Logobox.logo_exists?(ico)`

Returns true if logo exists on logobox. If ICO is invalid or logo doesn't exist on logobox returns false. Does actual http request to retrieve this information.
```ruby
Logobox.logo_exists?(12345678) # Invalid ico
=> false
```

##### `Logobox.generate_logo_url(ico, size = :medium)`

Generates url for logo by given ICO. Logobox provides 3 sizes of logos. You can pick the size by providing second argument. It can be :small/:medium/:big. Default is :medium.
```ruby
Logobox.generate_logo_url(12345678)
=> "http://www.logobox.cz/getimage.ashx?id=CZ12345678"

Logobox.generate_logo_url(12345678, :small)
=> "http://www.logobox.cz/getimage.ashx?id=CZ12345678&size=small"
```

##### `Logobox.generate_logo_url!(ico, size = :medium)`

Works same as non bang method but if ICO is invalid or logo doesn't exist on Logobox it raises `ArgumentError` or `Logobox::LogoNotFound`. Again you can pick size with second optional argument.
```ruby
Logobox.generate_logo_url!(12345678)
=> ArgumentError: ico is invalid

Logobox.generate_logo_url!(29137420)
=> Logobox::LogoNotFound: logo does not exists

Logobox.generate_logo_url!(27082440)
=> "http://www.logobox.cz/getimage.ashx?id=CZ27082440"
```

### Rails example
```ruby
class Company < ActiveRecord::Base
  ...
  def logo_url
    Logobox.generate_logo_url(self.ico, :medium)
  end
  ...
end
```

```html
<%= image_tag(@contact.logo_url) %>
```
