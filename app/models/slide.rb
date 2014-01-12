class Slide < ActiveRecord::Base

  # associations
  belongs_to :event
  has_one :channel

  # validations
  validates :title, presence: true, allow_blank: false
  validates_presence_of :event
  validates_datetime :end_date, if: :start_date, allow_nil: true, on_or_after: :start_date
  validates_datetime :end_date, unless: :start_date, allow_nil: true, is_at: Time.at(0)
  validates_datetime :start_date, if: :end_date, allow_nil: false, on_or_before: :end_date
  validates_datetime :start_date, unless: :end_date, allow_nil: true, on_or_before: lambda{|m| Time.now}

  # behaviours
  acts_as_taggable

  # on save
  before_save :sanitize_data

  def timeline_data
    data = { headline: title }
    data[:text]      = description if description
    data[:tag]       = tag_list.join(", ") if tag_list.any?
    data[:startDate] = start_date.strftime("%Y,%m,%d") if start_date
    data[:endDate]   = end_date.strftime("%Y,%m,%d")   if end_date
    data[:classname] = class_name if class_name
    data[:asset]     = channel.timeline_data if channel
    data
  end

  private

    def sanitize_data
      self.cover = true unless self.event.cover
      self.class_name = nil if self.class_name.blank?
      self.description = nil if self.description.blank?
    end
end
