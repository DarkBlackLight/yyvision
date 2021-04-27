class ProblemCategory < ApplicationRecord
  has_ancestry
  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }
  scope :query_level, ->(q) { where level: q }
  scope :query_level, ->(q) { where ancestry: q }

  enum level: [:common, :general, :serious]
end
