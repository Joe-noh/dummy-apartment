#-*- coding: utf-8 -*-

require "dummy-apartment/version"
require 'psych'

class DummyApartment
  YML = File.expand_path('../data.yml', __FILE__)

  NON_ZERO = (1..9).to_a.map(&:to_s)
  NUM      = NON_ZERO + ['0']
  NUM_DASH = NUM + ['-']

  @@dic ||=  Psych.load(File.open(YML).read)

  ATTRIBUTES = [:address, :building_name, :geo, :top_floor, :room_floor, :room_number, :room_type, :keeping_pets,
                :playing_the_instruments, :place_for_washing_machine, :floor_type, :exposure,
                :air_conditioner_equipped, :self_locking, :manager_patrol, :nearest_stations,
                :minutes_to_stations]

  attr_accessor *ATTRIBUTES

  def self.generate
    address                   = gen_address
    building_name             = gen_building_name
    geo                       = gen_long_lat
    top_floor                 = gen_top_floor
    room_floor                = gen_room_floor(top_floor)
    room_number               = gen_room_number(room_floor)
    room_type                 = gen_room_type
    keeping_pets              = ['可', '不可', '要相談'].sample
    playing_the_instruments   = ['可', '不可'].sample
    place_for_washing_machine = ['室内', '室外', '無し'].sample
    floor_type                = [:flooring, :tatami].sample
    exposure                  = [:north, :south, :east, :west].sample
    air_conditioner_equipped  = gen_true_or_false
    self_locking              = gen_true_or_false
    manager_patrol            = gen_true_or_false
    nearest_stations          = gen_nearest_stations
    minutes_to_stations       = gen_minutes_to_stations(nearest_stations.size)

    values = ATTRIBUTES.map{ |attr| eval "#{attr}" }
    DummyApartment.new(Hash[ATTRIBUTES.zip values])
  end

  def initialize(apartment_hash)
    assign_attributes(apartment_hash)
  end

  def flooring?
    @floor_type == :flooring
  end

  def tatami?
    @floor_type == :tatami
  end

  def air_conditioner_equipped?
    @air_conditioner_equipped
  end

  def self_locking?
    @self_locking
  end

  def manager_patrol?
    @manager_patrol
  end

  def to_hash
    Hash[ATTRIBUTES.map{|attr| [attr, instance_variable_get("@#{attr}")] }]
  end

  def self.gen_address
    prefs  = @@dic['prefectures']
    cities = @@dic['cities']

    street = NON_ZERO.sample + NUM.sample(rand 1..3).join
    dash_index = rand(street.length-1)
    street.insert(dash_index, '-') if dash_index != 0 and dash_index != street.length

    [prefs.sample, cities.sample, street].join
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

  def self.gen_room_type
    types = @@dic['room_type']
    types.sample
  end

  def self.gen_true_or_false
    [true, false].sample
  end

  def self.gen_nearest_stations
    number = Math.sqrt(rand 1..4).floor  # 1 with 3/4, 2 with 1/4
    @@dic['station'].sample number
  end

  def self.gen_minutes_to_stations(num_of_stations)
    num_of_stations.times.with_object([]){ |i, array|
      on_foot = rand(1 .. 30)
      by_bus  = rand(1 .. on_foot)
      array << {on_foot: on_foot, by_bus: by_bus}
    }
  end

  private_class_method *self.public_methods.grep(/\Agen_/)

  private

  def assign_attributes(hash)
    ATTRIBUTES.each do |attr|
      self.instance_variable_set("@#{attr}".to_sym, hash[attr])
    end
  end
end

