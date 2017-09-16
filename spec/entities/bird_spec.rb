require 'spec_helper'

describe 'Bird' do

  let(:bird) { Bird.new(100, 200, 2, 2) }

  it 'should the score equal to 0' do
    expect(bird.score).to eq 0
  end

  it 'should the vel_y are negative' do
    bird.set_pain_y
    expect(bird.vel_y).to eq -2
  end

  it 'should the vel_x are negative' do
    bird.set_pain_x
    expect(bird.vel_x).to eq -2
  end

  it 'should the method up rest vel_y' do
    bird.up
    expect(bird.vel_y).to eq 1
  end
end