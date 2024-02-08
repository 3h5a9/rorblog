class Article < ApplicationRecord
  belongs_to :category
  has_one_attached :featured_image
  has_rich_text :content
  belongs_to :user
end
