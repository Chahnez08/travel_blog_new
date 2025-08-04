class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true
  validates :location, presence: true
  has_rich_text :content
  before_save :set_content_text

  include PgSearch::Model
  multisearchable against: [:title, :content_text]

  private

  def set_content_text
    self.content_text = content.body.to_plain_text
  end

end
