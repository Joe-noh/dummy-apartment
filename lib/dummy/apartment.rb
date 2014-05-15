require "dummy/apartment/version"

require 'psych'

module Dummy
  class Apartment
    YML = File.expand_path('../../data.yml', __FILE__)

    NON_ZERO = (1..9).to_a.map(&:to_s)
    NUM      = NON_ZERO + ['0']
    NUM_DASH = NUM + ['-']

    def self.generate
      @@dic ||=  Psych.load(File.open(YML).read)

      address     = gen_address
      name        = gen_building_name
      geo         = gen_long_lat
      top_floor   = gen_top_floor
      room_floor  = gen_room_floor(top_floor)
      room_number = gen_room_number(room_floor)

      {
        address: address, building_name: name, geo: geo,
        top_floor: top_floor, room_floor: room_floor,
        room_number: room_number
      }
    end

    def self.gen_address
      prefs  = @@dic['prefectures']
      cities = @@dic['cities']
      number = NON_ZERO.sample
      number += rand(5).times.select{ NUM_DASH.sample }.join
      number.gsub!(/\-0|0\-/, '-')

      [prefs.sample, cities.sample, number].join
    end

    def self.gen_building_name
      names = @@dic['building_name']
      names['first_half'].sample + names['second_half'].sample
    end

    def self.gen_long_lat
      # only around Kanto
      longitude = rand( 35.668559 ..  37.276341)
      latitude  = rand(138.419373 .. 140.572693)

      [longitude, latitude]
    end

    def self.gen_top_floor
      rand(2 .. 4)
    end

    def self.gen_room_floor(limit)
      rand(1 .. limit)
    end

    def self.gen_room_number(floor)
      "#{floor}0#{rand(0..9)}"
    end

    private_class_method *self.public_methods.grep(/\Agen_/)
  end
end
