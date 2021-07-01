class PortraitSearch < ApplicationRecord
  belongs_to :portrait
  belongs_to :admin
  has_many :portrait_search_results, dependent: :destroy

  validates :source_type, presence: true

  after_create :setup_portrait_search_results

  def setup_portrait_search_results
    tags = []

    if source_type == 'CameraCapture' && search_from && search_to && search_from <= search_to
      tag_date = search_from
      while tag_date <= search_to
        tags.append(tag_date.strftime('%F'))
        tag_date = tag_date + 1.day
      end
    end

    vectors = milvus_search_vectors(self.source_type, self.portrait, self.size)
    vectors.each do |vector|
      if milvus_confidence(vector["distance"]) >= self.confidence
        PortraitSearchResult.create(portrait_search_id: self.id,
                                    target_id: vector["id"],
                                    target_confidence: milvus_confidence(vector["distance"])
        )
      end
    end
  end

end
