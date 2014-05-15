require 'spec_helper'

describe Dummy::Apartment do

  it 'should generate a hash' do
    expect(Dummy::Apartment.generate).to be_a Hash
  end

  describe 'Building Name' do

    subject { Dummy::Apartment.generate[:building_name] }

    it { should_not be_empty }
  end
end
