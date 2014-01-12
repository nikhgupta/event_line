require 'spec_helper'

describe Slide do

  subject { build(:slide) }

  # associations
  it { should have_one(:channel) }
  it { should belong_to(:event)  }
  it { should have_many(:tags) }

  # validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:event) }
  it { should allow_value(nil).for(:channel) }
  it { should_not allow_value("   ", nil).for(:title) }
  it { should allow_value("   ", nil).for(:class_name) }
  it { should allow_value("   ", nil).for(:description) }

  # should be valid without a start date and end date
  it { should allow_value(nil).for(:start_date) }
  it { should allow_value(nil).for(:end_date) }

  # should not be valid when start date is in future
  it { should_not allow_value(1.day.since).for(:start_date)}
  # should be valid with a start date in the past
  it { should allow_value(1.day.ago).for(:start_date)}

  # should not be valid with end date without a start date
  it { should_not allow_value(1.day.ago).for(:end_date) }

  # should not be valid for invalid values on start or end dates
  it { should_not allow_value("INVALID DATE").for(:start_date) }
  it { should_not allow_value("INVALID DATE").for(:end_date) }

  # end date is before start date
  it { should allow_value(1.day.ago).for(:start_date); should_not allow_value(2.day.ago).for(:end_date) }
  # end date is after start date
  it { should allow_value(2.day.ago).for(:start_date); should allow_value(1.day.ago).for(:end_date) }

  # tags
  it "should be taggable" do
    # slide = build(:slide_with_tags, tags_count: 3)
    slide = create(:slide, tags_count: 2)
    expect(slide.tag_list.count).to eq(2)
  end

  # on save
  context "when being saved" do
    it "strips whitespace from description" do
      slide = create(:slide, description: "   ")
      expect(slide.description).to be_nil
    end
  end

  # timeline.js
  context "with #timeline_data" do
    it "outputs a hash of data required for the timeline" do
      slide = create(:slide_with_channel, description: "<p>HTML</p>", class_name: "unique", tags_count: 2)
      result = slide.timeline_data
      expected = { headline: slide.title, text: "<p>HTML</p>", tag: "tag_1, tag_2",
                    classname: "unique", asset: {media: slide.channel.url}}

      expect(result).to eq(expected)
    end

    it "outputs a hash of data for the timeline along with the dates" do
      slide = create(:slide, start_date: 3.days.ago, end_date: 2.days.ago)
      result = slide.timeline_data
      expected = { headline: slide.title,
                   startDate: 3.days.ago.strftime("%Y,%m,%d"),
                   endDate: 2.days.ago.strftime("%Y,%m,%d") }
      expect(result).to eq(expected)
    end
  end
end
