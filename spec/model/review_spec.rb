require 'spec_helper'

describe Review do
  it "include mongo module" do
    expect(Review).to include(Mongoid::Document)
  end

end
