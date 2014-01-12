require 'spec_helper'

describe Channel do

  subject { build(:channel) }

  # associations
  it { should belong_to(:slide) }

  # validations
  it { should validate_presence_of(:url) }
  it { should allow_value("   ", nil).for(:caption) }
  it { should allow_value("   ", nil).for(:credit) }
  it { should allow_value("   ", nil).for(:thumbnail) }
  it { should validate_presence_of(:slide) }

  # url validation
  it { should allow_value('http://github.com', 'https://google.com/something?as=da').for(:url)}
  it { should_not allow_value('http://', 'asdasda', "//google.com", "   ", nil).for(:url)}

  # on save
  context "when being saved" do
    it "should trim whitespace on caption, credits and thumbnail" do
      channel = create(:channel, thumbnail: "  ", caption: "   ", credit: " ")
      expect(channel.credit).to be_nil
      expect(channel.caption).to be_nil
      expect(channel.thumbnail).to be_nil
    end
  end

  # timeline.js
  context "with #timeline_data" do
    it "outputs a hash of data required for the timeline" do
      channel  = create(:channel)
      result   = channel.timeline_data
      expected = { media: channel.url }
      expect(result).to eq(expected)
    end

    it "outputs a hash of data for the timeline with filled details" do
      channel  = create(:channel, caption: "some caption", credit: "  ")
      result   = channel.timeline_data
      expected = { media: channel.url, caption: "some caption" }
      expect(result).to eq(expected)
    end
  end
end
