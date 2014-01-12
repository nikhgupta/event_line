require 'spec_helper'

describe Language do
  it { should have_many(:events) }
  it "is pre-fileld by seed task" do
    expect { Language.find(9) }.not_to raise_error
  end
end
