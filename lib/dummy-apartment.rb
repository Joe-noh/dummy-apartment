require "dummy-apartment/version"

require 'psych'

class DummyApartment
  YML = File.expand_path('../data.yml', __FILE__)

  NON_ZERO = (1..9).to_a.map(&:to_s)
  NUM      = NON_ZERO + ['0']
  NUM_DASH = NUM + ['-']

  @@dic ||=  Psych.load(File.open(YML).read)

  ATTRIBUTES = %i(address building_name geo top_floor room_floor room_number)

  attr_reader *ATTRIBUTES

  def self.generate
    address       = gen_address
    building_name = gen_building_name
    geo           = gen_long_lat
    top_floor     = gen_top_floor
    room_floor    = gen_room_floor(top_floor)
    room_number   = gen_room_number(room_floor)

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

  def method_missing(method_name, *args)
    @hash.send(method_name, *args) if @hash.respond_to? method_name
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

  private

  def assign_attributes
    ATTRIBUTES.each do |attr|
      self.instance_variable_set("@#{attr}".to_sym, @hash[attr])
    end
  end
end

