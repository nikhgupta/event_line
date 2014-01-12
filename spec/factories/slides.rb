# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slide do

    ignore do
      tags_count 0
    end

    event
    title "Slide's Title"

    after(:create) do |slide, evaluator|
      if evaluator.tags_count > 0
        slide.tag_list = (1..evaluator.tags_count).map{|i| "tag_#{i}"}.join(", ")
      end
    end
  end

  factory :slide_with_channel, parent: :slide do
    after(:create) do |slide, evaluator|
      create_list(:channel, 1, slide: slide)
    end
  end
end
