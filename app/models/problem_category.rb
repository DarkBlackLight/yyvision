class ProblemCategory < ApplicationRecord
  belongs_to :parent, class_name: 'ProblemCategory', optional: true
  has_many :children, class_name: 'ProblemCategory'

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }

  enum level: [:common, :general, :serious]
end
