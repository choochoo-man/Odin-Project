require 'spec_helper'
require_relative '../tic_tac_toe.rb'

RSpec.describe 'tic_tac_toe' do
  describe '#set player names' do
    it 'sets player one' do
      expect((NewGame.new("Bill", "Ted")).playerone).to eq("Bill")
    end

    it 'sets player two' do
      expect((NewGame.new("Bill", "Ted")).playertwo).to eq("Ted")
    end
    
  end
end