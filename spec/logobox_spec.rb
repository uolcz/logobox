require 'spec_helper'

describe Logobox, :vcr do
  describe '::generate_logo_url' do
    context 'no size is given' do
      it "creates basic url for logobox logo" do
        expect(Logobox.generate_logo_url(27169278)).to eq 'http://www.logobox.cz/getimage.ashx?id=CZ27169278'
      end
    end

    context 'size is given' do
      it 'creates basic url for logobox logo with size parameter' do
        expect(Logobox.generate_logo_url(27169278, :small)).to eq 'http://www.logobox.cz/getimage.ashx?id=CZ27169278?size=small'
      end

      it "raises an ArgumentError if size isn't small, medium or big" do
        expect{ Logobox.generate_logo_url(27169278, :nonsense) }.to raise_error(ArgumentError, 'size must be one of :small, :medium, :big')
      end
    end
  end

  describe '::generate_logo_url!' do
    context 'no size is given' do
      it "creates basic url for logobox logo" do
        expect(Logobox.generate_logo_url!(27169278)).to eq 'http://www.logobox.cz/getimage.ashx?id=CZ27169278'
      end
    end

    context 'size is given' do
      it 'creates basic url for logobox logo with size parameter' do
        expect(Logobox.generate_logo_url!(27169278, :small)).to eq 'http://www.logobox.cz/getimage.ashx?id=CZ27169278?size=small'
      end

      it "raises an ArgumentError if size isn't small, medium or big" do
        expect { Logobox.generate_logo_url!(27169278, :nonsense) }.to raise_error(ArgumentError, 'size must be one of :small, :medium, :big')
      end

      it 'fails if logo does not exists' do
        expect { Logobox.generate_logo_url!(62966758) }.to raise_error(Logobox::LogoNotFound, 'logo does not exists')
      end

      it 'fails if ico is invalid' do
        expect { Logobox.generate_logo_url!(123) }.to raise_error(ArgumentError, 'ico is invalid')
      end
    end
  end

  describe '::logo_exists' do
    it 'returns true on valid ico and if logo exist' do
      expect(Logobox.logo_exists?(27169278)).to eq true
    end

    it 'returns false on invalid ico' do
      expect(Logobox.logo_exists?(123)).to eq false
    end

    it 'returns false on non-existen ico' do
      expect(Logobox.logo_exists?(62966758)).to eq false
    end
  end
end

