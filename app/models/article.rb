class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  
  # accepts_nested_attributes_for :taggings
  
  belongs_to :user
  belongs_to :url
end
