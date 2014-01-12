class Language < ActiveRecord::Base
  # associations
  has_many :events
end
