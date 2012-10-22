# Warden::Redirect

Simple gem for throwing redirects in warden.

## Installation

Add this line to your application's Gemfile:

    gem 'warden-redirect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install warden-redirect

## Usage

To use with a specific location:

    throw :warden, Warden::Redirect.new('/location')

To use with a specific location and status:

    throw :warden, Warden::Redirect.new('/location',301)

To use with a specific location, status and extra headers:

    throw :warden, Warden::Redirect.new('/location',301, "X-SHALL-NOT-PASS" => true)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
