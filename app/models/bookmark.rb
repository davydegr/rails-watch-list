class Bookmark < ApplicationRecord
  belongs_to :list
  belongs_to :movie

  validates :movie, uniqueness: { scope: :list,
                                  message: 'Only unique movie/list combinations are allowed' }

  validates :comment, length: { minimum: 6 }
end
