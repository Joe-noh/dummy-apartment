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
    subject { Dummy::Apartment.generate[:building_name] }

    it { should_not be_empty }
  end

  describe 'Address' do
    subject { Dummy::Apartment.generate[:address] }

    it { should match /[都道府県]/ }
    it { should match /[市町村]/ }
    it { should match /[0-9]/ }
  end
end
