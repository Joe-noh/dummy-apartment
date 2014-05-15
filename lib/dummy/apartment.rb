require "dummy/apartment/version"

require 'psych'

module Dummy
  class Apartment
    YML = File.expand_path('../../data.yml', __FILE__)

    def self.generate
      @@dic ||=  Psych.load(File.open(YML).read)

      names = @@dic['building_name']
      name = names['first_half'].sample + names['second_half'].sample

      {building_name: name}
    end
  end
end
