class Body < ApplicationRecord
  belongs_to :source, polymorphic: true

  serialize :box, Array
end
