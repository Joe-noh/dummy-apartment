## Dummy::Apartment

This gem generates dummy information of apartment including

* address
* building name
* latitude/longitude
* floor/top
* room number

### Installation

Add this line to Gemfile:

    gem 'dummy-apartment'

And then:

    $ bundle

Or just:

    $ gem install dummy-apartment

### Usage

    DummyApartment.generate
     #=> {:address       => "群馬県長谷市60",
     #    :building_name => "江頭Petit",
     #    :geo           => [36.878327083956236, 139.92838722714708],
     #    :top_floor     => 4,
     #    :room_floor    => 2,
     #    :room_number   => "203"}


### Contributing

1. Fork it ( https://github.com/Joe-noh/dummy-apartment/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request, will be welcomed.
