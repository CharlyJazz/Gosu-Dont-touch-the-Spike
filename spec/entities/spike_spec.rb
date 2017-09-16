require 'spec_helper'

describe 'Spike' do

  let(:spike) { Spike.new(100, 200, true) }

  it 'should angle for default equal to 270' do
    expect(spike.angle_right).to eq 270
  end
end