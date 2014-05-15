require 'spec_helper'

describe Dummy::Apartment do
  let(:apartment) { Dummy::Apartment.generate }

  it 'should generate a hash' do
    expect(apartment).to be_a Hash
  end

  it 'should have no public class method starts with "gen_"' do
    public_methods = Dummy::Apartment.public_methods(false)
    expect(public_methods.grep /\Agen_/).to be_empty
  end

  describe 'Building Name' do
    let(:name){ apartment[:building_name] }

    it 'should not be empty' do
      expect(name).not_to be_empty
    end
  end

  describe 'Address' do
    let(:address){ apartment[:address] }

    it 'should match address format' do
      expect(address).to match /[都道府県].+[市町村].*[0-9]/
    end
  end

  describe 'Geo' do
    let(:geo){ apartment[:geo] }

    it 'should be a couple of Float' do
      expect(geo.map(&:class)).to eql [Float, Float]
    end
  end

  describe 'Room Floor and Top Floor' do
    let(:top_floor) { apartment[:top_floor]  }
    let(:room_floor){ apartment[:room_floor] }

    it 'should have valid floor information' do
      expect( top_floor).to be >= room_floor
      expect( top_floor).to be >= 1
      expect(room_floor).to be >= 1
    end
  end
end
