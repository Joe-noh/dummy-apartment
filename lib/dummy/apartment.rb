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

      name    = gen_building_name
      address = gen_address

      {address: address, building_name: name}
    end

    def self.gen_building_name
      names = @@dic['building_name']
      names['first_half'].sample + names['second_half'].sample
    end

    def self.gen_address
      prefs  = @@dic['prefectures']
      cities = @@dic['cities']
      number = NON_ZERO.sample
      number += rand(5).times.select{ NUM_DASH.sample }.join
      number.gsub!(/\-0|0\-/, '-')

      [prefs.sample, cities.sample, number].join
    end

    private_class_method *self.public_methods.grep(/\Agen_/)
  end
end
