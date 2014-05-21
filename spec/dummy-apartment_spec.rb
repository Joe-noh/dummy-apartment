#-*- coding: utf-8 -*-

require 'spec_helper'

describe DummyApartment do
  before do
    @apartment = DummyApartment.generate
  end

  it 'should generate a DummyApartment object' do
    expect(@apartment).to be_a DummyApartment
  end

  describe 'to_hash Method' do
    it 'should return a Hash object' do
      expect(@apartment.to_hash).to be_a Hash
    end

    describe 'The Hash' do
      it 'should consist with the DummyApartment object' do
        hash = @apartment.to_hash
        DummyApartment::ATTRIBUTES.each do |attr|
          expect(hash[attr]).to eql @apartment.send(attr)
        end

        @apartment.address = 'somewhere'
        expect(@apartment.to_hash[:address]).to eql 'somewhere'
      end
    end
  end

  it 'should have the accessor methods' do
    DummyApartment::ATTRIBUTES.each do |attr|
      expect(@apartment.respond_to?          attr).to be_true
      expect(@apartment.respond_to? "#{attr}=").to be_true
    end
  end

  it 'should raise when pass an argument which is not String or Symbol' do
    expect { @apartment[0] }.to raise_error
  end

  it 'should have no public class method starts with "gen_"' do
    public_methods = DummyApartment.public_methods(false)
    expect(public_methods.grep /\Agen_/).to be_empty
  end

  describe 'Building Name' do
    it 'should not be empty' do
      100.times do
        expect(Build.building_name).not_to be_empty
      end
    end
  end

  describe 'Address' do
    it 'should match address format' do
      100.times do
        expect(Build.address).to match /[都道府県].+[市町村].*[0-9]/
      end
    end
  end

  describe 'Geo' do
    it 'should be a couple of Float' do
      expect(Build.geo.map(&:class)).to eql [Float, Float]
    end
  end

  describe 'Room Floor and Top Floor' do
    it 'should have valid floor information' do
      100.times do
        top_floor, room_floor = Build[:top_floor, :room_floor]

        expect( top_floor).to be >= room_floor
        expect( top_floor).to be >= 1
        expect(room_floor).to be >= 1
      end
    end
  end

  describe 'Room Number' do
    it 'should be a three-character string' do
      room_number = Build.room_number

      expect(room_number).to be_a String
      expect(room_number.length).to eql 3
    end

    it 'should be consistent with room floor' do
      100.times do
        room_number, room_floor = Build[:room_number, :room_floor]
        expect(room_number).to start_with room_floor.to_s
      end
    end
  end

  describe 'Room Type' do
    let(:room_type){ @apartment.room_type }

    it 'should be a String object' do
      expect(Build.room_type).to be_a String
    end

    it 'should be match the format' do
      100.times do
        expect(Build.room_type).to match /\A\d(R|[LDK]{1,3})\z/
      end
    end
  end

  describe 'Occupied Area' do
    it 'should be correspond to room_type' do
      100.times do
        type, area = Build[:room_type, :occupied_area]
        range = case type
                when '1R';   (15.0 .. 25.0)
                when '1K';   (15.0 .. 25.0)
                when '1DK';  (25.0 .. 35.0)
                when '1LDK'; (35.0 .. 45.0)
                when '2K';   (25.0 .. 35.0)
                when '2DK';  (35.0 .. 45.0)
                when '2LDK'; (45.0 .. 55.0)
                when '3K';   (35.0 .. 45.0)
                when '3DK';  (45.0 .. 55.0)
                when '3LDK'; (55.0 .. 65.0)
                end
        expect(range).to include area
      end
    end
  end

  describe 'Keeping Pets' do
    it 'should be a String object' do
      expect(Build.keeping_pets).to be_a String
    end

    it 'should equal "可", "不可" or "要相談"' do
      100.times do
        expect(Build.keeping_pets).to match /\A(可|不可|要相談)\z/
      end
    end
  end

  describe 'Playing the Instruments' do
    it 'should be a String object' do
      expect(Build.playing_the_instruments).to be_a String
    end

    it 'should equal "可" or "不可"' do
      100.times do
        expect(Build.playing_the_instruments).to match /\A不?可\z/
      end
    end
  end

  describe 'Place for Washing Machine' do
    it 'should be a String object' do
      expect(Build.place_for_washing_machine).to be_a String
    end

    it 'should equal "室内", "室外" or "無し"' do
      100.times do
        expect(Build.place_for_washing_machine).to match /\A(室内|室外|無し)\z/
      end
    end
  end

  describe 'Floor Type' do
    it 'should be a Symbol' do
      expect(Build.floor_type).to be_a Symbol
    end

    it 'should equal :flooring or :tatami' do
      100.times do
        expect([:flooring, :tatami]).to include Build.floor_type
      end
    end

    it 'should consistent between #floor_type, #tatami? and #flooring?' do
      100.times do
        apartment = DummyApartment.generate

        case apartment.floor_type
        when :flooring
          expect(apartment.flooring?).to be_true
          expect(apartment.tatami?).to   be_false
        when :tatami
          expect(apartment.flooring?).to be_false
          expect(apartment.tatami?).to   be_true
        end
      end
    end
  end

  describe 'Exposure' do
    it 'should be a Symbol' do
      expect(Build.exposure).to be_a Symbol
    end

    it 'should be equal :north, :south, :east or :west' do
      100.times do
        expect([:north, :south, :east, :west]).to include Build.exposure
      end
    end
  end

  describe 'Air Conditioner' do
    it 'should be consist between #air_conditioner_equipped and #air_conditioner_equipped?' do
      100.times do
        apartment = DummyApartment.generate
        expect(apartment.air_conditioner_equipped).to eql apartment.air_conditioner_equipped?
      end
    end
  end

  describe 'Self Locking' do
    it 'should be consist between #self_locking and #self_locking?' do
      100.times do
        apartment = DummyApartment.generate
        expect(apartment.self_locking).to eql apartment.self_locking?
      end
    end
  end

  describe "Manager's Patrol" do
    it 'should be consist between #manager_patrol and #manager_patrol?' do
      100.times do
        apartment = DummyApartment.generate
        expect(apartment.manager_patrol).to eql apartment.manager_patrol?
      end
    end
  end

  describe 'Nearest Stations' do
    let(:nearest_stations){ @apartment.nearest_stations }

    it 'should be an Array of Strings' do
      expect(nearest_stations).to be_an Array
      expect(nearest_stations.all?{|s| String === s}).to be_true
    end

    it 'should be an Array whose size is one or two' do
      100.times do
        expect(Build.nearest_stations.size).to be_between(1, 2)
      end
    end

    describe "Stations' Name" do
      it "should end with '駅'" do
        100.times do
          expect(Build.nearest_stations.all?{|name| name.end_with? '駅'}).to be_true
        end
      end
    end
  end

  describe 'Minutes to Stations' do
    let(:minutes_to_stations){ @apartment.minutes_to_stations }

    it 'should be an Array of Hashes' do
      expect(minutes_to_stations).to be_an Array
      expect(minutes_to_stations.all?{|h| Hash === h}).to be_true
    end

    it 'should be an Array the size of which is equal to of nearest_stations' do
      100.times do
        nearests, minutes = Build[:nearest_stations, :minutes_to_stations]
        expect(nearests.size).to eql minutes.size
      end
    end

    it 'should have relation on_foot >= by_bus' do
      100.times do
        minutes = Build.minutes_to_stations.first
        on_foot = minutes[:on_foot]
        by_bus  = minutes[:by_bus]

        expect(on_foot).to be >= by_bus
      end
    end
  end
end
