class PortraitSearchResult < ApplicationRecord
  belongs_to :portrait_search
  belongs_to :target, class_name: 'Portrait'

  validates :target_confidence, presence: true
end
