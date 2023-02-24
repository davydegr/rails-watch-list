class Movie < ApplicationRecord
  has_many :bookmarks
  has_one_attached :photo

  validates :title, presence: true
  validates :overview, presence: true
  validates :title, uniqueness: true
  validates :overview, uniqueness: true
end
