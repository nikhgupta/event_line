require 'spec_helper'

describe Event do

  subject { build(:event) }

  # associations
  it { should have_many(:slides) }
  it { should belong_to(:language) }
  it { should belong_to(:map_type) }
  it { should belong_to(:font) }

  # validations
  it { should validate_presence_of(:title) }
  it { should_not allow_value("    ", nil).for(:title) }
  it { should allow_value("   ", nil).for(:description) }

  # defaults
  context "with default settings" do
    before { @event = build(:event) }
    it "has English as default language" do
      expect(@event.language.code).to eq("en")
    end
    it "has WaterColor map as the default map type" do
      expect(@event.map_type.name).to eq("watercolor")
    end
    it "has 'PTSerif-PTSans' as the default font" do
      expect(@event.font.name).to eq("PTSerif-PTSans")
    end
  end

  # on save
  context "when being saved" do
    it "strips whitespace from description" do
      event = create(:event, description: "   ")
      expect(event.description).to be_nil
    end
  end

  # without associated slides
  context "without any associated slides" do
    it "does not have a cover slide" do
      event = create(:event)
      expect(event.cover).to be_nil
    end
  end

  # with associated slides
  context "with associated slides" do
    it "has a cover slide" do
      event = create(:event_with_slides, slides_count: 2)
      expect(event.cover).to be_a(Slide)
    end
  end

  # timeline.js
  context "with #timeline_data" do
    it "outputs a hash of data required for the timeline" do
      event = create(:event_with_slides, slides_count: 2, with_channel: true)
      result = event.timeline_data
      expected = { timeline: {
        headline: event.slides[0].title,
        type: "default",
        asset: { media: event.slides[0].channel.url },
        date: [ { headline: event.slides[1].title, asset: { media: event.slides[1].channel.url }, } ] } }
      expect(result).to eq(expected)
    end

    it "outputs a nil object when associated slides are not present" do
      event = create(:event)
      result = event.timeline_data
      expect(result).to be_nil
    end
  end

  context "with #timeline_json" do
    it "outputs a json for timeline.js" do
      event = create(:event_with_slides, slides_count: 2, with_channel: true)
      result = event.timeline_json
      expected = event.timeline_data.to_json
      expect(result).to eq(expected)
    end

    it "outputs an appropriate json when no slides are associated" do
      event = create(:event)
      result = event.timeline_json
      expected = { timeline: { headline: "No Slides Found :(" } }.to_json
      expect(result).to eq(expected)
    end
  end

end
