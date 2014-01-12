# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "Event's Title"
  end

  factory :event_with_slides, parent: :event do
    ignore do
      slides_count 5
      with_channel false
    end

    after(:create) do |event, evaluator|
      if evaluator.with_channel
        create_list(:slide_with_channel, evaluator.slides_count, event: event)
      else
        create_list(:slide, evaluator.slides_count, event: event)
      end
    end
  end
end
