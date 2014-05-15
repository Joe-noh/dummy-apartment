require 'spec_helper'

describe Dummy::Apartment do

  it 'should generate a hash' do
    expect(Dummy::Apartment.generate).to be_a Hash
  end

  it 'should have no public class method starts with "gen_"' do
    public_methods = Dummy::Apartment.public_methods(false)
    expect(public_methods.grep /\Agen_/).to be_empty
  end

  describe 'Building Name' do
    let(:name){ Dummy::Apartment.generate[:building_name] }

    it 'should not be empty' do
      expect(name).not_to be_empty
    end
  end

  describe 'Address' do
    let(:address){ Dummy::Apartment.generate[:address] }

    it 'should match address format' do
      expect(address).to match /[都道府県].+[市町村].*[0-9]/
    end
  end

  describe 'Geo' do
    let(:geo){ Dummy::Apartment.generate[:geo] }

    it 'should be a couple of Float' do
      expect(geo.map(&:class)).to eql [Float, Float]
    end
  end
end
