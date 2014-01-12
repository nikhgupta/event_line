require 'spec_helper'

describe MapType do
  it { should have_many(:events) }
  it "is pre-filled by seed task" do
    expect { MapType.find(4) }.not_to raise_error
  end
end
