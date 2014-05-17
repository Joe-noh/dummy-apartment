require 'spec_helper'

describe DummyApartment do
  before do
    @apartment = DummyApartment.generate
  end

  it 'should generate a DummyApartment object' do
    expect(@apartment).to be_a DummyApartment
  end

  it 'should delegate to Hash' do
    expect(@apartment.respond_to? :keys).to be_false
    expect(@apartment.keys).to be_an Array
  end

  it 'should access the attribute via the method which has same name as the attribute' do
    expect(@apartment.room_number).to eql @apartment[:room_number]
    expect(@apartment.address).to     eql @apartment[:address]
  end

  it 'should access the attribute using both String and Symbol' do
    expect(@apartment['address']).to eql @apartment.address
    expect(@apartment[:address]).to  eql @apartment.address
  end

  it 'should be overwritten its attributes' do
    @apartment.address = ''
    expect(@apartment.address).to be_empty
    @apartment[:address] = 'somewhere'
    expect(@apartment.address).to eql 'somewhere'
  end

  it 'should have consistency' do
    @apartment.address = 'somewhere'
    expect(@apartment.address).to eql @apartment[:address]
    expect(@apartment.address).to eql @apartment['address']
  end

  it 'should raise when pass an argument which is not String or Symbol' do
    expect { @apartment[0] }.to raise_error
  end

  it 'should have no public class method starts with "gen_"' do
    public_methods = DummyApartment.public_methods(false)
    expect(public_methods.grep /\Agen_/).to be_empty
  end

  describe 'Building Name' do
    let(:name){ @apartment[:building_name] }

    it 'should not be empty' do
      expect(name).not_to be_empty
    end
  end

  describe 'Address' do
    let(:address){ @apartment[:address] }

    it 'should match address format' do
      expect(address).to match /[都道府県].+[市町村].*[0-9]/
    end
  end

  describe 'Geo' do
    let(:geo){ @apartment[:geo] }

    it 'should be a couple of Float' do
      expect(geo.map(&:class)).to eql [Float, Float]
    end
  end

  describe 'Room Floor and Top Floor' do
    let(:top_floor) { @apartment[:top_floor]  }
    let(:room_floor){ @apartment[:room_floor] }

    it 'should have valid floor information' do
      expect( top_floor).to be >= room_floor
      expect( top_floor).to be >= 1
      expect(room_floor).to be >= 1
    end
  end

  describe 'Room Number' do
    let(:room_floor) { @apartment[:room_floor] }
    let(:room_number){ @apartment[:room_number] }

    it 'should be a three-character string' do
      expect(room_number).to be_a String
      expect(room_number.length).to eql 3
    end

    it 'should be consistent with room floor' do
      expect(room_number).to start_with room_floor.to_s
    end
  end

  describe 'Room Type' do
    let(:room_type){ @apartment[:room_type] }

    it 'should be a String object' do
      expect(room_type).to be_a String
    end

    it 'should be match the format' do
      expect(room_type).to match /\A\d(R|[LDK]{1,3})\z/
    end
  end

  describe 'Keeping Pets' do
    let(:keeping_pets){ @apartment[:keeping_pets] }

    it 'should be a String object' do
      expect(keeping_pets).to be_a String
    end

    it 'should equal "可", "不可" or "要相談"' do
      expect(keeping_pets).to match /\A(可|不可|要相談)\z/
    end
  end

  describe 'Playing the Instruments' do
    let(:playing_the_instruments){ @apartment[:playing_the_instruments] }

    it 'should be a String object' do
      expect(playing_the_instruments).to be_a String
    end

    it 'should equal "可" or "不可"' do
      expect(playing_the_instruments).to match /\A不?可\z/
    end
  end

  describe 'Place for Washing Machine' do
    let(:place_for_washing_machine){ @apartment[:place_for_washing_machine] }

    it 'should be a String object' do
      expect(place_for_washing_machine).to be_a String
    end

    it 'should equal "室内", "室外" or "無し"' do
      expect(place_for_washing_machine).to match /\A(室内|室外|無し)\z/
    end
  end

  describe 'Floor Type' do
    let(:floor_type){ @apartment[:floor_type] }

    it 'should be a Symbol' do
      expect(floor_type).to be_a Symbol
    end

    it 'should equal :flooring or :tatami' do
      expect([:flooring, :tatami]).to include floor_type
    end

    it 'should consistent between #floor_type, #tatami? and #flooring?' do
      case floor_type
      when :flooring
        expect(@apartment.flooring?).to be_true
        expect(@apartment.tatami?).to   be_false
      when :tatami
        expect(@apartment.flooring?).to be_false
        expect(@apartment.tatami?).to   be_true
      end
    end
  end

  describe 'Exposure' do
    let(:exposure){ @apartment[:exposure] }

    it 'should be a Symbol' do
      expect(exposure).to be_a Symbol
    end

    it 'should be equal :north, :south, :east or :west' do
      expect([:north, :south, :east, :west]).to include exposure
    end
  end
end
