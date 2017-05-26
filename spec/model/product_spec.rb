require 'spec_helper'

describe Product do
  it "include mongo module" do
    expect(Product).to include(Mongoid::Document)
  end
end
