require "dummy-apartment/version"

require 'psych'

class DummyApartment
  YML = File.expand_path('../data.yml', __FILE__)

  NON_ZERO = (1..9).to_a.map(&:to_s)
  NUM      = NON_ZERO + ['0']
  NUM_DASH = NUM + ['-']

  @@dic ||=  Psych.load(File.open(YML).read)

  ATTRIBUTES = %i(address building_name geo top_floor room_floor room_number room_type keeping_pets) +
               %i(playing_the_instruments place_for_washing_machine floor_type)

  attr_reader *ATTRIBUTES

  def self.generate
    address       = gen_address
    building_name = gen_building_name
    geo           = gen_long_lat
    top_floor     = gen_top_floor
    room_floor    = gen_room_floor(top_floor)
    room_number   = gen_room_number(room_floor)
    room_type     = gen_room_type
    keeping_pets  = gen_keeping_pets
    playing_the_instruments   = gen_playing_the_instruments
    place_for_washing_machine = gen_place_for_washing_machine
    floor_type    = gen_floor_type

    values = ATTRIBUTES.map{ |attr| eval "#{attr}" }
    DummyApartment.new(Hash[ATTRIBUTES.zip values])
  end

  def initialize(apartment_hash)
    @hash = apartment_hash
    assign_attributes
  end

  def [](key)
    case key
    when String; @hash[key.to_sym]
    when Symbol; @hash[key]
    else; raise
    end
  end

  def []=(key, value)
    case key
    when String; assign(key.to_sym, value)
    when Symbol; assign(key,        value)
    else; raise
    end
  end

  def assign(key, value)
    if ATTRIBUTES.member? key
      @hash[key] = value
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  ATTRIBUTES.each do |attr|
    eval <<-RUBY
      def #{attr}=(value)
        @hash[:#{attr}] = value
        @#{attr} = value
      end
    RUBY
  end

  def flooring?
    @floor_type == :flooring
  end

  def tatami?
    @floor_type == :tatami
  end

  def method_missing(method_name, *args)
    @hash.send(method_name, *args) if @hash.respond_to? method_name
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

  def self.gen_keeping_pets
    ['可', '不可', '要相談'].sample
  end

  def self.gen_playing_the_instruments
    ['可', '不可'].sample
  end

  def self.gen_place_for_washing_machine
    ['室内', '室外', '無し'].sample
  end

  def self.gen_floor_type
    [:flooring, :tatami].sample
  end

  private_class_method *self.public_methods.grep(/\Agen_/)

  private

  def assign_attributes
    ATTRIBUTES.each do |attr|
      self.instance_variable_set("@#{attr}".to_sym, @hash[attr])
    end
  end
end

