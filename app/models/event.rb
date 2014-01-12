class Event < ActiveRecord::Base

  # associations
  has_many :slides
  belongs_to :language
  belongs_to :map_type
  belongs_to :font

  # validations
  validates :title, presence: true, allow_blank: false

  # on save
  before_save :sanitize_data

  def cover
    slides.where(cover: true).first
  end

  def timeline_data
    return nil if self.slides.empty?
    _slides = self.slides.where(cover: false).map(&:timeline_data)
    { timeline: self.cover.timeline_data.merge(type: "default", date: _slides) }
  end

  def timeline_json
    data = self.timeline_data
    data ||= { timeline: { headline: "No Slides Found :(" } }
    data.to_json
  end

  private

  def sanitize_data
    self.description = nil if self.description.blank?
  end

end
