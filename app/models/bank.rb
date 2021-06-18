class Bank < ApplicationRecord
  has_ancestry

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }
  scope :query_ancestry, -> (q) { where(ancestry: q) }

  has_many :bank_people, dependent: :destroy
  has_many :people, through: :bank_people

  after_commit :setup_children_tag
  after_destroy_commit :destroy_all_children

  def destroy_all_children
    self.children.destroy_all
  end

  def setup_children_tag
    if self.previous_changes[:if_black]
      self.children.update_all(if_black: self.if_black)
    elsif self.self.previous_changes[:if_red]
      self.children.update_all(if_red: self.if_red)
    end
  end
end
