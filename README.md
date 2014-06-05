## DummyApartment
[![Build Status](https://travis-ci.org/Joe-noh/dummy-apartment.png)](https://travis-ci.org/Joe-noh/dummy-apartment)
[![Gem Version](https://badge.fury.io/rb/dummy-apartment.png)](http://badge.fury.io/rb/dummy-apartment)

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
* direction the window facing
* air conditioner is equipped or not
* is self-locking door?
* whether the manager patrols
* names of closest stations
* minutes to reach the stations
  * on foot
  * by bus
* whether bath and toilet are in different rooms
* date of
  * construction
  * renovation
* monthly rent
* monthly management fee
* monthly parking price
* deposit money
* finder's reward
* leasing term is fixed or not
  * the term if it's fixed
  * renewal fee if it's fixed

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

    # Get attributes
    apartment.address       #=> "群馬県長谷市60"
    apartment.building_name #=> "石井コーポ"
    apartment.room_floor    #=> 2

    # Overwrite
    apartment.building_name = "ハイツ谷川"

    # Convert to Hash
    apartment.to_hash
    #=> {address: "群馬県長谷市60", building_name: "ハイツ谷川", ... }

### Contributing

1. Fork it ( https://github.com/Joe-noh/dummy-apartment/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request, will be welcomed.
