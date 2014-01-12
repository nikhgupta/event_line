require 'spec_helper'

describe Font do
  it { should have_many(:events) }
  it "is pre-filled by seed task" do
    expect{ Font.find(4) }.not_to raise_error
  end
end
