## DummyApartment

This gem generates dummy information of apartment including

* address
* building name
* latitude/longitude
* floor/top
* room number
* room type
* keeping pets
* playable the musical instruments or not
* floor type

### Installation

Add this line to Gemfile:

    gem 'dummy-apartment'

And then:

    $ bundle

Or just:

    $ gem install dummy-apartment

### Usage

    require 'dummy-apartment'

    apartment = DummyApartment.generate

    apartment.address       #=> "群馬県長谷市60"
    apartment.building_name #=> "石井コーポ"
    apartment_room_floor    #=> 2

    apartment[:room_floor]  #=> 2
    apartment['room_floor'] #=> 2

### Contributing

1. Fork it ( https://github.com/Joe-noh/dummy-apartment/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request, will be welcomed.
