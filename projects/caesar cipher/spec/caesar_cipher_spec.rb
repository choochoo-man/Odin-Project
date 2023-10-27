require 'spec_helper'
require_relative '../caesar_cipher.rb'

RSpec.describe 'caesar cipher' do
  describe '#caesar_cipher' do
    it 'shifts lowercase' do
      expect(caesar_cipher("daniel", 2)).to eq("fcpkgn")
    end

    it 'shifts lowercase' do
      expect(caesar_cipher("85:", 2)).to eq("ccc")
    end
    
    it 'shifts upcase' do
      expect(caesar_cipher("DANIEL", 2)).to eq("FCPKGN")
    end

    it 'shifts mixed case' do
      expect(caesar_cipher("Daniel", 2)).to eq("Fcpkgn")
    end
    
    it 'shifts correct amount' do
      expect(caesar_cipher("z", 3)).to eq("c")
    end

    it 'shifts 100 times' do
      expect(caesar_cipher("a", 100)).to eq("w")
    end
  end

  describe "#is_upcase?" do
    context "When the character is uppercase" do
      it 'upcase true' do
        expect(is_upcase?("A")).to eq(true)
      end
    end

    context "When the character is lowercase" do
      it 'upcase_false' do
        expect(is_upcase?("a")).to eq(false)
      end
    end
  end
  describe 'Alphabet constants'
end