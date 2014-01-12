class Font < ActiveRecord::Base
  # associations
  has_many :events
end
