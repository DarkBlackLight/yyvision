class PortraitSearch < ApplicationRecord
  belongs_to :portrait
  belongs_to :admin
  has_many :portrait_search_results, dependent: :destroy

  validates :source_type, presence: true

  after_create :setup_portrait_search_results

  def setup_portrait_search_results
    vectors = milvus_search_vectors(self.source_type, self.portrait, self.size)
    vectors.each do |vector|
      PortraitSearchResult.create(portrait_search_id: self.id,
                                  target_id: vector["id"],
                                  target_confidence: milvus_confidence(vector["distance"])
      )
    end
  end

end
