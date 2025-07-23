class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true
  validates :location, presence: true
end
