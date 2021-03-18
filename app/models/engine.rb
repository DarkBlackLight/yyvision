class Engine < ApplicationRecord

  scope :query_secret, -> (q) { where(secret: q) }

  has_many :camera_captures
  has_one :user, as: :source, dependent: :destroy
  accepts_nested_attributes_for :user

  enum engine_type: [:engine, :api]

  before_validation :setup_secret
  validates :full_name, :secret, :device, presence: true
  after_create :create_user

  def setup_secret
    unless self.secret
      o = [(0..9), ('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      self.secret = (loop do
        token = (0...20).map { o[rand(o.length)] }.join
        break token unless Engine.where(secret: token).exists?
      end)
    end
  end

  def create_user
    unless user
      self.update({ user_attributes: { username: self.full_name, password: self.secret, token: self.secret, token_created_at: Time.now } })
    end
  end
end
