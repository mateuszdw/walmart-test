require 'spec_helper'

describe ProductCrawler do

  let(:product) { ProductCrawler.new('Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789') }
  let(:wrong_product) { ProductCrawler.new('Ematic') }

  it 'returns valid name' do
    VCR.use_cassette('product') do
      expect(product.name).to eq("Ematic 9\" Dual Screen Portable DVD Player with Dual DVD Players (ED929D)")
    end
  end

  it 'returns valid price' do
    VCR.use_cassette('product') do
      expect(product.price.to_f).to be_a(Float)
    end
  end

  it '#html Nokogiri when valid product' do
    VCR.use_cassette('product') do
      expect(product.html).to be_instance_of(Nokogiri::HTML::Document)
    end
  end

  it '#html false when wrong product' do
    VCR.use_cassette('wrong_product') do
      expect(wrong_product.html).to be(false)
    end
  end

end
