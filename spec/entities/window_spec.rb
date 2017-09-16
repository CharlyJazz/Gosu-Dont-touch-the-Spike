require 'spec_helper'

describe DontTouchTheSpikes do

  it 'should have the correct caption' do
    expect(subject.caption).to eq 'Dont touch the spikes'
  end

  it 'should the height is equal to 600' do
    expect(subject.height).to eq 600
  end

  it 'should the width is equal to 600' do
    expect(subject.width).to eq 350
  end

end