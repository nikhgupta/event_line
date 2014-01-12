class Channel < ActiveRecord::Base

  # associations
  belongs_to :slide

  # validations
  validates :url, presence: true, url: true, allow_blank: false
  validates_presence_of :slide

  # on save
  before_save :sanitize_data

  def timeline_data
    data = { media: url }
    data[:thumbnail] = thumbnail if thumbnail
    data[:credit]    = credit    if credit
    data[:caption]   = caption   if caption
    data
  end

  private

    def sanitize_data
      self.thumbnail = nil if self.thumbnail.blank?
      self.caption   = nil if self.caption.blank?
      self.credit    = nil if self.credit.blank?
    end
end
