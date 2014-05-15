require 'spec_helper'

describe 'data.yml' do
  let(:dic){ Dummy::Apartment.class_variable_get :@@dic }

  it 'should not have duplicated items' do
    expect(dic['prefectures'] - dic['prefectures'].uniq).to be_empty
    expect(dic['cities']      - dic['cities'].uniq     ).to be_empty
    expect(dic['building_name'][ 'first_half'] - dic['building_name'][ 'first_half'].uniq).to be_empty
    expect(dic['building_name']['second_half'] - dic['building_name']['second_half'].uniq).to be_empty
  end
end