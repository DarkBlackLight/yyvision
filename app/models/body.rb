class Body < ApplicationRecord
  belongs_to :source, polymorphic: true, counter_cache: true

  serialize :box, Array

  before_create :format_features

  def format_features
    self.box = self.box.map { |box| box.to_f }
  end
end
