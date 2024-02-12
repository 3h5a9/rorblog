class Article < ApplicationRecord
  belongs_to :category
  has_one_attached :featured_image do |attachable|
    attachable.variant :thumb, resize_to_fill: [900, 250]
  end
  has_rich_text :content
  belongs_to :user
  has_many :comments, dependent: :destroy
end
